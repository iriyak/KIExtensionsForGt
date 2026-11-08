Extension { #name : 'BlElement' }

{ #category : '*KIExtensionsForGt' }
BlElement >> exportAsPNGInActualSize [
	"Export the receiver's image as a PNG in actual size by in-place transforming bounds from a local coordinates to childrens' coordinates. See BlPngExporter>>#doExportInActualSize:."

	<return: #FileReference>
	^ BlExporter png
		element: self;
		exportInActualSize
]
