Class {
	#name : #SmaCCDefinitionNode,
	#superclass : #SmaCCParseNode,
	#category : #'SmaCC_Grammar_Parser'
}

{ #category : #generated }
SmaCCDefinitionNode >> acceptVisitor: aDefinitionVisitor [
	^ aDefinitionVisitor visitDefinition: self
]

{ #category : #accessing }
SmaCCDefinitionNode >> allReferencesTo: aString [
	| refs |
	refs := OrderedCollection new.
	self topParent
		allNodesDo: [ :each | 
			(((each isKindOf: SmaCCSymbolNode) or: [ each isKindOf: SmaCCTokenRegexNode ])
				and: [ each name value = aString ])
				ifTrue: [ refs add: each ] ].
	^ refs
]

{ #category : #testing }
SmaCCDefinitionNode >> isGroup [
	^ false
]

{ #category : #accessing }
SmaCCDefinitionNode >> lookupRule: aString [
	self topParent rules
		do: [ :each | 
			((each isKindOf: SmaCCProductionRuleNode) or: [ each isKindOf: SmaCCTokenRuleNode ])
				ifTrue: [ each name value = aString
						ifTrue: [ ^ each ] ] ].
	^ nil
]

{ #category : #accessing }
SmaCCDefinitionNode >> rule [
	^ self
		lookupNode: [ :node | (node isKindOf: SmaCCProductionRuleNode) or: [ node isKindOf: SmaCCTokenRuleNode ] ]
]

{ #category : #accessing }
SmaCCDefinitionNode >> ruleReferences [
	^ #()
]

{ #category : #accessing }
SmaCCDefinitionNode >> ruleReferencesTo: aString [
	| rules |
	rules := Set new.
	(self allReferencesTo: aString)
		do: [ :ref | ref rule ifNotNil: [ :rule | rules add: rule ] ].
	^ rules
		asSortedCollection: [ :a :b | a startPosition < b startPosition ]
]

{ #category : #accessing }
SmaCCDefinitionNode >> uses [
	| rules |
	rules := Set new.
	self
		allNodesDo: [ :each | 
			((each isKindOf: SmaCCSymbolNode) or: [ each isKindOf: SmaCCTokenRegexNode ])
				ifTrue: [ (self lookupRule: each name value) ifNotNil: [ :rule | rules add: rule ] ] ].
	^ rules asSortedCollection: [ :a :b | a startPosition < b startPosition ]
]
