Extension { #name : 'GtPhlowMondrianView' }

{ #category : '*KIExtensionsForGt' }
GtPhlowMondrianView >> initialize [
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x "do nothing by default" |  ].
	transformation := [ :x "by default there is no transformation" | x ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomin asElement;
				label: 'Zoom in';
				action: [ mondrianElement zoomIn ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomout asElement;
				label: 'Zoom out';
				action: [ mondrianElement zoomOut ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons zoomtofit asElement;
				label: 'Zoom to fit';
				action: [ mondrianElement zoomToFit ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Reset to actual size';
				icon: BrGlamorousVectorIcons actualsize asElement;
				action: [ mondrianElement zoomToActualSize ] ].
	self
		actionStencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Save as PNG in actual size';
				icon: BrGlamorousVectorIcons save asElement;
				action: [ :aButton | aButton phlow spawnObject: mondrianElement exportAsPNGInActualSize ] ]
]
