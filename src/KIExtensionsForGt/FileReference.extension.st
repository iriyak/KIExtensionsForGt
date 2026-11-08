Extension { #name : 'FileReference' }

{ #category : '*KIExtensionsForGt' }
FileReference >> longPathName [
	"Return the long form of the shortened full path name of the receiver."

	| platform buffer r |
	platform := OSPlatform current.
	buffer := Win32WideString new: platform defaultMaximumPathLength.
	r := platform
			getLongPathName: self pathString asWin32WideString
			buffer: buffer
			size: platform defaultMaximumPathLength.
	r = 0
		ifTrue: [ self error: 'Error while calling getLongPathName() for ' , self pathString ].
	^ buffer asString
]

{ #category : '*KIExtensionsForGt' }
FileReference >> shortenedName [
	"Return the shortened full path name of the receiver."

	| platform buffer r |
	platform := OSPlatform current.
	buffer := Win32WideString new: platform defaultMaximumPathLength.
	r := platform
			getShortPathName: self pathString asWin32WideString
			buffer: buffer
			size: platform defaultMaximumPathLength.
	r = 0
		ifTrue: [ self error: 'Error while calling getShortPathName() for ' , self pathString ].
	^ buffer asString
]
