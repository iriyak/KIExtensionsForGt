Extension { #name : 'LePage' }

{ #category : '*KIExtensionsForGt' }
LePage >> gtOpenCertainPageActionFor: anAction [
	"Experimental - Adding a button to navigate to a certain page stored in playgroundDB."

	<lePageAction>
	| playgroundDB aLePage actionBlock |
	playgroundDB := LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
			playgroundDB.
	aLePage := (LePage named: 'Playground').
	actionBlock := [ :aButton | 
		aButton
			withAllParentsDetect: [ :anElement | anElement class = LePageToolElement ]
			ifFound: [ :anElement | 
				anElement sidebarElement
					fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aLePage asContentUIModel) ]
			ifNone: [  ] ].
	^ anAction button
		tooltip: 'Open a specified page';
		icon: BrGlamorousVectorIcons browse;
		action: actionBlock
]

{ #category : '*KIExtensionsForGt' }
LePage >> gtOpenMultipleLePagesActionFor: anAction [
	"Experimental - Adding a button to open LePages stored in playgroundDB in a new tab."

	<lePageAction>
	| names action1 action2 playgroundDB |
	playgroundDB := LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
			playgroundDB.
	names := {'Extending PostgreSQL snippet, PostgreSQL login snippet'.
			'My Workspace'.
			'Customizing Inspector by introducing a custom view'.
			'GtP3 trial & error'}.
	action1 := [ :aName :aButton | 
		| aPage |
		aPage := playgroundDB pageNamed: aName.
		BlSpace new
			pageInPager: aPage;
			withSceneDriller;
			showFrom: aButton ].
	action2 := [ :aName :aButton | 
		| aPage |
		aPage := playgroundDB pageNamed: aName.
		aButton phlow showObject: aPage ].
	^ anAction button
		tooltip: 'Open registered pages';
		icon: BrGlamorousVectorIcons up;
		action: [ :aButton | names do: [ :aName | action1 value: aName value: aButton ] ];
		primaryModifierAction: [ :aButton | names do: [ :aName | action2 value: aName value: aButton ] ]
]
