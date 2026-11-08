Extension { #name : 'Behavior' }

{ #category : '*KIExtensionsForGt' }
Behavior >> gtMyOverviewFor: aView [
	<gtClassView>
	^ aView explicit
		title: 'Overview';
		tooltip: 'Overview';
		priority: 1;
		disableAsync;
		stencil: [ | left right contentBuilder labelBuilder className |
			contentBuilder := [ BlElement new
					layout: BlLinearLayout vertical;
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ] ].
			labelBuilder := [ :s | 
				BrLabel new
					aptitude: (BrGlamorousLabelAptitude new
							foreground: Color veryVeryDarkGray;
							fontSize: 16;
							bold);
					hMatchParent;
					text: s asRopedText ].
			className := self gtDisplayString , ' class'.
			left := contentBuilder value
					addChildren: {labelBuilder value: 'Comments for ' , className.
							GtInspector forObject: self viewSelector: #gtCoderLepiterCommentsFor:.
							labelBuilder value: 'References for ' , className.
							GtInspector forObject: self viewSelector: #gtAllReferencesFor:.
							labelBuilder value: 'Examples for ' , className.
							GtInspector forObject: self viewSelector: #gtExamplesFor:context:}.
			right := contentBuilder value
					addChildren: {labelBuilder value: 'Methods for ' , className.
							GtInspector
								forObject: self
								viewSelector: #gtCoderStreamingMethodsFor:context:}.
			BrHorizontalPane new
				matchParent;
				addChildren: {left.
						right} ]
]
