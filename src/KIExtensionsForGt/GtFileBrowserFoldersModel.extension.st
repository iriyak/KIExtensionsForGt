Extension { #name : 'GtFileBrowserFoldersModel' }

{ #category : '*KIExtensionsForGt' }
GtFileBrowserFoldersModel >> findFileBrowserFolderModel: aFolder ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."

	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>
	^ self fileBrowserFolderModels
		detect: [ :eachFileBrowserFolderModel | 
			aFolder fileSystem isCaseSensitive
				ifTrue: [ eachFileBrowserFolderModel fileReference = aFolder ]
				ifFalse: [ OSPlatform current isWindows
						ifTrue: [ (eachFileBrowserFolderModel fileReference pathString
								sameAs: aFolder pathString)
								or: [ eachFileBrowserFolderModel fileReference shortenedName
										sameAs: aFolder shortenedName ] ]
						ifFalse: [ eachFileBrowserFolderModel fileReference pathString
								sameAs: aFolder pathString ] ] ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]
