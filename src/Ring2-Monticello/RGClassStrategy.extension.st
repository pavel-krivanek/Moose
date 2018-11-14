Extension { #name : #RGClassStrategy }

{ #category : #'*Ring2-Monticello' }
RGClassStrategy >> asMCDefinition [

	^ MCClassDefinition 
		name: self name
		superclassName: (self superclass ifNil: [ 'nil' ] ifNotNil: [ :aSuperclass | aSuperclass name ])
		traitComposition: self owner traitCompositionString 
		classTraitComposition: self owner metaclass traitCompositionString
		category: self category 
		instVarNames: self instVarNames
		classVarNames: self classVarNames
		poolDictionaryNames: self sharedPoolNames
		classInstVarNames: self metaclass instVarNames
		type: self mcType
		comment: self comment content
		commentStamp: self comment stamp
]

{ #category : #'*Ring2-Monticello' }
RGClassStrategy >> classLayout [
	"TODO"
	^ layout"
		ifNil: [ 
			| superLayout scope |
			superLayout := superclass classLayout.
			scope := superLayout slotScope extend.
			layout := superLayout class extending: superLayout scope: scope host: self ]"
]

{ #category : #'*Ring2-Monticello' }
RGClassStrategy >> classPool [

	"TODO"
	^ Dictionary newFrom: (self classVarNames collect: [ :each | each -> nil ])
]

{ #category : #'*Ring2-Monticello' }
RGClassStrategy >> mcType [

	^ self layout mcType
]

{ #category : #'*Ring2-Monticello' }
RGClassStrategy >> referencedPackages [

	^ Array with: self package.
]