class window.MakeUpLoader
  constructor: ->
    @makeUpReload()
  makeUpReload: ->
    arrayOfInputElements = document.getElementsByTagName('input')
    for element in arrayOfInputElements
      inputType = element.getAttribute('data-format')
      new window.MakeUp(inputType, element)

document.addEventListener "DOMContentLoaded", ->
  new window.MakeUpLoader()
