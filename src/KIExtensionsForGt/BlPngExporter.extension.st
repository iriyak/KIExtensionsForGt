Extension { #name : 'BlPngExporter' }

{ #category : '*KIExtensionsForGt' }
BlPngExporter >> doExportInActualSize: aFinalizingBlock [
	| aCanvas theElement diagram theBounds parentElement |
	theElement := self element.
	theElement zoomToFit.
	parentElement := theElement parent.
	diagram := BlScripter new
			extent: theElement childrenBoundingBox extent asIntegerPoint;
			element: theElement;
			elementWithoutParent.
	theBounds := diagram localBoundsToChildren: diagram bounds inLocal bounds.
	aCanvas := self createCanvas: theBounds extent.
	aCanvas transform
		by: [ :t | t scaleBy: 1.0 / diagram childrenScaleFactor ]
		during: [ diagram fullDrawOnSpartaCanvas: aCanvas ].
	parentElement addChild: theElement.
	^ aFinalizingBlock cull: aCanvas
]

{ #category : '*KIExtensionsForGt' }
BlPngExporter >> exportInActualSize [
	<return: #FileReference>
	(self element isKindOf: BlCanvassableElement) ifFalse: [ ^ self export ].
	^ self
		doExportInActualSize: [ :aCanvas | 
			| aForm |
			aForm := aCanvas asForm.

			self fileName asFileReference ensureDelete.
			PNGReadWriter putForm: aForm onFileNamed: self fileName.

			self fileName asFileReference ]
]
