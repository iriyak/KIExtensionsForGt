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
		spec
			baseline: 'GToolkit4P3'
			with: [ spec repository: 'github://feenkcom/gt4p3' ].
		spec package: 'KIExtensionsForGt'.
		spec
			package: 'KIExtensionsForGToolkit4P3'
			with: [ spec requires: #('GToolkit4P3') ] ]
]
