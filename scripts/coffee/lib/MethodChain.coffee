_Interface = require './_Interface'

module.exports = class MethodChain

	constructor: ->

		@_methods = {}

		@_Interface = class I extends _Interface

	addMethod: (name) ->

		@_Interface::[name] = ->

			@_queue.push

				method: name

				args: Array::slice.call arguments

			@

		@

	getInterface: ->

		new @_Interface

	run: (_interface, context, transform = null) ->

		for item in _interface._queue

			if transform?

				args = transform item.args

			else

				args = args

			context = context[item.method].apply context, args

		context