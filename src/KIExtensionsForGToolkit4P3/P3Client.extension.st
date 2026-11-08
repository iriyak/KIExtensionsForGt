Extension { #name : 'P3Client' }

{ #category : '*KIExtensionsForGToolkit4P3' }
P3Client class >> gtViewAllInstancesIn: composite [
	"
	Remarks
	
	1. 'composite columnedList' creates a GtPhlowColumnedListView.
	2. The view collects P3Clients by 'self allInstances'.  So not performant.
	3. Start/stop fails while user/password/database is left as blank.
	
	"

	<gtClassView>
	^ composite columnedList
		title: 'Instances';
		priority: 8;
		items: [ self allInstances ];
		column: ''
			stencil: [ :e | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons shutdown;
					label: 'Start/stop PostgreSQL client connection';
					action: [ e isConnected ifTrue: [ e close ] ifFalse: [ e ensureConnected ] ] ]
			weight: 0.75;
		column: 'connected'
			text: [ :e | 
				e isConnected
					in: [ :boolean | 
						boolean asRopedText
							foreground: (boolean
									ifTrue: BrGlamorousColors successBorderColor
									ifFalse: BrGlamorousColors errorBorderColor) ] ];
		column: 'session' text: [ :e | e session ifNil: '' ];
		column: 'host' text: [ :e | e host ifNil: '' ];
		column: 'port' text: [ :e | e port ifNil: '' ];
		column: 'client' text: [ :e | e class ifNil: '' ];
		column: 'url'
			text: [ :e | e url ifNil: '' ]
			weight: 3;
		column: 'user' text: [ :e | e user ifNil: '' ];
		column: 'password' text: [ :e | e password ifNil: '' ];
		column: 'database' text: [ :e | e database ifNil: '' ];
		column: 'ssl' text: [ :e | e isSSL ifNil: '' ];
		column: 'options' text: [ :e | e startupOptions ifNil: '' ];
		updateWhen: P3ConnectionClosedEvent in: [ P3LogEvent announcer ];
		updateWhen: P3ConnectionEstablishedEvent in: [ P3LogEvent announcer ];
		actionUpdateButton
]
