Class {
	#name : 'P3ConfigHolder',
	#superclass : 'Object',
	#instVars : [
		'configs',
		'lastConfig'
	],
	#classVars : [
		'uniqueInstance'
	],
	#category : 'KIExtensionsForGToolkit4P3',
	#package : 'KIExtensionsForGToolkit4P3'
}

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder class >> gtConfigViewFor: aView [
	<gtClassView>
	^ aView forward
		title: 'Configs';
		priority: 8;
		object: [ self uniqueInstance ];
		view: #gtConfigViewFor:
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder >> configs [
	^ configs
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder >> gtConfigViewFor: aView [
	"Copied from Dictionary>>#gtItemsFor:"

	<gtView>
	^ aView columnedTree
		title: 'Configs';
		priority: 8;
		items: [ self configs associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key'
			text: [ :assoc | assoc key ]
			weight: 2.0;
		column: ''
			stencil: [ :assoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude;
					label: 'Save';
					action: [ P3ClientLoginPane2 new
							loadFromConfig: assoc;
							saveToDefaultConnection ] ]
			weight: 0.8;
		column: 'Value'
			text: [ :assoc | assoc value ]
			weight: 9;
		contextItemLabel: 'Inspect key'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value key ];
		contextItemLabel: 'Inspect value'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value value ];
		contextItemLabel: 'Inspect association'
			action: [ :anElement :aTreeNode | anElement phlow spawnObject: aTreeNode value ];
		contextItemLabel: 'Remove key and value'
			action: [ :anElement :aTreeNode | 
				self configs removeKey: aTreeNode value key ifAbsent: [  "ignore" ].
				anElement phlow contextMenuUpdateViewContent ];
		send: [ :assoc "Implementation note: association sorting uses #collatedBy: to avoid a 'Symbol DNU value: value: error'" | assoc value ];
		updateWhen: ValueChanged in: [ self configs announcer ];
		actionUpdateButton
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder >> initialize [
	configs := Dictionary new asValueHolder.
	lastConfig := 'database' -> Dictionary new
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder >> lastConfig [
	^ lastConfig
]

{ #category : 'KIExtensionsForGToolkit4P3' }
P3ConfigHolder >> lastConfig: aConfig [

lastConfig := aConfig
]
