{CompositeDisposable, TextEditor} = require 'atom'

module.exports =
class CodePeekView
  constructor: ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('code-peek')

    @subscriptions = new CompositeDisposable

    @text = null
    @editRange = null
    @originalTextEditor = null

    @grammarReg = atom.grammars

    @grammar = null

    @textEditor = null

  # Tear down any state and detach
  destroy: ->
    @subscriptions.dispose()
    @element.remove()

  setupForEditing: (functionInfo, originalTextEditor) ->
    @text = functionInfo.text
    @editRange = functionInfo.range
    @originalTextEditor = originalTextEditor

    @grammar = @grammarReg.selectGrammar(@originalTextEditor.getPath(), @text)

    @textEditor = new TextEditor()
    @textEditor.setGrammar(@grammar)

  attachTextEditorView: ->
    if not @text? or not @editRange? or not @originalTextEditor?
      throw new Error "Not all parameters set"

    @textEditor.setText(@text)
    textEditorView = atom.views.getView(@textEditor)
    @element.appendChild(textEditorView)

  detachTextEditorView: ->
    newText = @textEditor.getText()

    @originalTextEditor.setTextInBufferRange(@editRange, newText)
    @originalTextEditor.save()

    @textEditor.destroy()

  getElement: ->
    @element
