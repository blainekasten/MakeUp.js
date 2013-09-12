###
 @{#}Object:        MakeUp
 @{#}Version:       1.1.0
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       A base class to extend and create different input
                    formatting tools.
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

class window.MakeUp
  keyMap: {65:'a', 66:'b', 67:'c', 68:'d', 69:'e', 70:'f', 71:'g', 72:'h', 73:'i', 74:'j', 75:'k', 76:'l', 77:'m', 78:'n', 79:'o', 80:'p', 81:'q', 82:'r', 83:'s', 84:'t', 85:'u', 86:'v', 87:'w', 88:'x', 89:'y', 90:'z', 48:0, 49:1, 50:2, 51:3, 52:4, 53:5, 54:6, 55:7, 56:8, 57:9, 96:0, 97:1, 98:2, 99:3, 100:4, 101:5, 102:6, 103:7, 104:8, 105:9, 190:'.', 191:'/', 111:'/', 8:"delete", 37:"left", 39:"right", 91:"cmd", 9:"tab", 16:"shift"}
  format: ''
  constructor: (inputType, @el) ->
    switch inputType
      when "phone" then new MakeUp.Phone(@el)
      when "date" then new MakeUp.Date(@el)
      when "numbers" then new MakeUp.Numbers(@el)
      when "numbers-with-decimals" then new MakeUp.Numbers(@el, 'decimals')
      when "email" then new MakeUp.Email(@el)
      when "state" then new MakeUp.State(@el)

  #
  ## bindEvents: ->
  ## The motherboard of this application.
  #
  bindEvents: ->
    @el.onkeydown = (e) =>
      unless @alwaysAcceptableKeys().includes(e.which) or e.metaKey
        e.preventDefault()
        @shouldApply = false
        @keydown(@keyMap[e.which])
    @el.onkeyup = (e) =>
      @keyup(@keyMap[e.which])
    @el.onblur = (e) =>
      @blur(e)

  modifyData: (modifyType, resetText = "") ->
    @el.blur()
    switch modifyType
      when "reset" then @el.value = resetText
      when "clear" then @el.value = ""
    setTimeout((=>
      @el.focus()
    ),300)

  #
  ## setPlaceholder
  ## placeholder = string for what the placeholder should default to
  ##            (this is typically an indicator of what the field should accept)
  #
  setPlaceholder: (placeholder) ->
    @el.placeholder = placeholder if @el.placeholder is ""

  #
  ## acceptedCharsAtIndex: ->
  ## regex = regex of acceptable chars
  ## index = int of string placement
  ## key = key that was pressed
  #
  acceptedCharsAtIndex: (regex, index, key) ->
    indices = index.toArray()
    currIndex = indices.includes(@el.value.length)

    if currIndex and regex.test(key)
      @shouldApply = true
    else
      @shouldApply = false
 
  acceptedChars: (regex, key) ->
    if regex.test(key)
      @shouldApply = true
    else @shouldApply = false



  #
  ## insertCharsAtIndex: ->
  ## str = String of characters
  ## index = int or array of string placement
  #
  insertCharsAtIndex: (str, index) ->
    if index instanceof Array
      for i in index
        if @el.value.length == i
          @el.value += str 
    else
      if @el.value.length == index
        @el.value += str 


  #
  ## checkLimit ->
  ## Checks if typing is past the limit
  #
  checkLimit: ->
    if @el.value.length >= @limit
      @shouldApply = false

  #
  ## applyChar: ->
  ## The final step in a makeup object
  #
  applyChar: (key) ->
    @el.value += key if @shouldApply is true 

  #
  ## alwaysAcceptableKeys: ->
  ## A list of always acceptable characters for fields
  ## generic arrows, metakeys, and delete keys
  #
  alwaysAcceptableKeys: ->
    [91, 16, 9, 8, 46, 37, 38, 39, 40]

  navigateSelectionBack: ->
     @el.setSelectionRange(0, -1)


  # Methods to be over-riden
  keydown: ->
  keyup: ->
  blur: ->
    @validate()
