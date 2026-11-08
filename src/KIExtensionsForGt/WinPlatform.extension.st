Extension { #name : 'WinPlatform' }

{ #category : '*KIExtensionsForGt' }
WinPlatform >> getLongPathName: lpszShortPath buffer: lpszLongPath size: cchBuffer [
	self
		ffiCall: #(long GetLongPathNameW #(Win32WideString lpszShortPath , void * lpszLongPath , ulong cchBuffer))
]

{ #category : '*KIExtensionsForGt' }
WinPlatform >> getShortPathName: lpszLongPath buffer: lpszShortPath size: cchBuffer [
	self
		ffiCall: #(long GetShortPathNameW #(Win32WideString lpszLongPath , void * lpszShortPath , ulong cchBuffer))
]

{ #category : '*KIExtensionsForGt' }
WinPlatform >> getTempPathNew [
	| length buffer1 buffer2 |
	length := self defaultMaximumPathLength.
	buffer1 := (String new: length) asWin32WideString.
	self getTempPath: length buffer: buffer1.
	buffer2 := (String new: length) asWin32WideString.
	self getLongPathName: buffer1 buffer: buffer2 size: length.
	^ buffer2 asString
]
