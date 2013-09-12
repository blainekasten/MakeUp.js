###
 @{#}Object:        MakeUp.Numbers
 @{#}Version:       1.0.0
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide number formatting to input fields
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

class MakeUp.Numbers extends MakeUp

  #
  ## constructor: ->
  #
  constructor: (@el, options = '') ->
    @format = "numbers"
    @bindEvents()

  #
  ## keydown: ->
  #
  keydown: (e) ->
    @shouldApply = false
    unless @alwaysAcceptableKeys().includes(e.which) or e.metaKey
      if e.metaKey
        @validatePaste()
      key = @keyMap[e.which]
      e.preventDefault()
      @acceptedChars(/[0-9]/, key)
      @applyChar(key)
