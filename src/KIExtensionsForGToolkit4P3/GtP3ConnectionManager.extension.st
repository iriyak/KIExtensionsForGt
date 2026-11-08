Extension { #name : 'GtP3ConnectionManager' }

{ #category : '*KIExtensionsForGToolkit4P3' }
GtP3ConnectionManager class >> gtDefaultConnectionFor: aView [
	<gtClassView>
	^ aView forward
		title: 'Connection';
		priority: 8;
		object: [ self uniqueInstance ];
		view: #gtDefaultConnectionFor:
]

{ #category : '*KIExtensionsForGToolkit4P3' }
GtP3ConnectionManager >> gtDefaultConnectionFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Connection';
		priority: 0;
		items: [ {self defaultConnection} ];
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

{ #category : '*KIExtensionsForGToolkit4P3' }
GtP3ConnectionManager class >> initialize [
	"self initialize"
	self environment 
		at: #SessionManager 
		ifPresent: [ :manager | manager default registerNetworkClassNamed: self name ]
		ifAbsent: [ Smalltalk addToStartUpList:  self ]
]

{ #category : '*KIExtensionsForGToolkit4P3' }
GtP3ConnectionManager class >> startUp [
	uniqueInstance
		ifNotNil: [ uniqueInstance defaultConnection
				ifNotNil: [ :connection | 
					connection close.
					P3SCRAM reset ] ]
]
