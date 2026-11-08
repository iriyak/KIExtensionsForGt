Extension { #name : 'GtGitRepository' }

{ #category : '*KIExtensionsForGt' }
GtGitRepository >> gtTestsFor: aView context: aPhlowContext [
	<gtView>
	<gtRepositoryView>
	| packages filter |
	packages := self hasWorkingCopy
			ifTrue: [ self icebergWorkingCopy packages
					select: [ :anIcePackage | anIcePackage isLoaded ]
					thenCollect: [ :anIcePackage | anIcePackage packageName asPackage ] ]
			ifFalse: [ #() ].
	filter := packages
			inject: GtSearchNullFilter new
			into: [ :acc :each | acc | (GtSearchPackageTestSuiteFilter new package: each) ].
	^ (GtPharoCoderUIUtility
		testMethodsPhlowViewFor: aView
		context: aPhlowContext
		filter: filter)
		title: 'Tests';
		priority: 20
]
