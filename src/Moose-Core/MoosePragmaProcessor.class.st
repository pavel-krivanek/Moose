"
I simply extend the FMPragmaProcessor to allow to filter the packages from where the meta model will be created.

Public API and Key Messages

- rejectedPackagesNames:
"
Class {
	#name : #MoosePragmaProcessor,
	#superclass : #FMPragmaProcessor,
	#instVars : [
		'rejectedPackages',
		'allowedPackages'
	],
	#category : #'Moose-Core'
}

{ #category : #private }
MoosePragmaProcessor >> allowPackageNamed: packageName [
	
	allowedPackages ifNil: [ allowedPackages := Set new ].
	
	allowedPackages add: packageName.
]

{ #category : #accessing }
MoosePragmaProcessor >> allowedPackageNames: aCollection [

	allowedPackages := aCollection
]

{ #category : #initialization }
MoosePragmaProcessor >> initialize [
	super initialize.
	rejectedPackages := nil.
	allowedPackages := nil.
]

{ #category : #private }
MoosePragmaProcessor >> packageNameAllowed: packageName [
	
	rejectedPackages ifNotNil: [ 
		^ (rejectedPackages includes: packageName) not ].
	
	allowedPackages ifNotNil: [ 
		^ allowedPackages includes: packageName ].
	
	^ true
]

{ #category : #private }
MoosePragmaProcessor >> processClass: aClass [
	^ self processClass: aClass ifPragmaAbsent: nil
]

{ #category : #private }
MoosePragmaProcessor >> rejectPackageNamed: packageName [
	
	rejectedPackages ifNil: [ rejectedPackages := Set new ].
	
	rejectedPackages add: packageName.
]

{ #category : #accessing }
MoosePragmaProcessor >> rejectedPackageNames: aCollection [
	"Define the Fame package that should not be imported.
	When a package is marked to be rejected, the classes and extension properties
	that are packaged in it will not be considered by the pragma processor
	and those definitions will not appear in the resulting meta repository."
	rejectedPackages := aCollection
]
