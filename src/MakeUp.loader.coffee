###
 @{#}Object:        MakeUpLoader
 @{#}Version:       1.1.0
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       An object to instantiate a MakeUp object, and give the ability to reload the makeup objects
 @{#}Author:        Blaine Kasten
 @{#}Copyright:     MIT License (MIT) Copyright (c) 2013 Blaine Kasten
                    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY 
                    OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
                    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
                    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
                    EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
                    FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
                    AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
                    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
                    OR OTHER DEALINGS IN THE SOFTWARE.
###

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
