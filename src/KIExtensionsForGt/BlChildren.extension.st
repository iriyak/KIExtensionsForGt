Extension { #name : 'BlChildren' }

{ #category : '*KIExtensionsForGt' }
BlChildren >> select: selectBlock thenCollect: collectBlock [
	^ Array
		streamContents: [ :aStream | 
			self
				do: [ :anElement | 
					(selectBlock value: anElement)
						ifTrue: [ aStream nextPut: (collectBlock value: anElement) ] ] ]
]
