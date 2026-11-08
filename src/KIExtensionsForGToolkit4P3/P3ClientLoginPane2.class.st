Class {
	#name : 'P3ClientLoginPane2',
	#superclass : 'P3ClientLoginPane',
	#instVars : [
		'name'
	],
	#category : 'KIExtensionsForGToolkit4P3',
	#package : 'KIExtensionsForGToolkit4P3'
}

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> defaultConfigHolder [
	^ P3ConfigHolder uniqueInstance
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> loadFrom: p3Client [
	self name: self defaultConfigHolder lastConfig key.
	super loadFrom: p3Client
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> loadFromConfig: aConfig [
	self name: aConfig key.
	#(host port user password database options ssl)
		do: [ :each | self perform: each asMutator with: (aConfig value at: each) ]
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> name [
	^ name
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> name: aString [
	name := aString
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 100;
		label: 'Name';
		accessor: #name;
		default: 'database'
]

{ #category : 'as yet unclassified' }
P3ClientLoginPane2 >> saveToDefaultConnection [
	| configHolder connection config |
	configHolder := self defaultConfigHolder.
	connection := self defaultConnection.
	config := self name
			-> (Dictionary
					newFrom: {'host' -> self host.
							'port' -> self port.
							'client' -> self class.
							'url' -> self url.
							'user' -> self user.
							'password' -> self password.
							'database' -> self database.
							'options' -> self options.
							'ssl' -> self ssl}).
	configHolder lastConfig: config.
	configHolder configs at: config key put: config value.
	super saveToDefaultConnection
]
