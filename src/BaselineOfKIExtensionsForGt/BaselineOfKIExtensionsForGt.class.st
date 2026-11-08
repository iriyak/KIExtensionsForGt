Class {
	#name : 'BaselineOfKIExtensionsForGt',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfKIExtensionsForGt',
	#package : 'BaselineOfKIExtensionsForGt'
}

{ #category : 'accessing' }
BaselineOfKIExtensionsForGt class >> loadLepiter [
	IceRepository registry
		detect: [ :aRepository |
			aRepository name = 'KIExtensionsForGt' ]
		ifFound: [ :aRepository |
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baselines' }
BaselineOfKIExtensionsForGt >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec package: 'KIExtensionsForGt' ]
]
