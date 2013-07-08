class window.MakeUp
  keyMap: {65:'a', 66:'b', 67:'c', 68:'d', 69:'e', 70:'f', 71:'g', 72:'h', 73:'i', 74:'j', 75:'k', 76:'l', 77:'m', 78:'n', 79:'o', 80:'p', 81:'q', 82:'r', 83:'s', 84:'t', 85:'u', 86:'v', 87:'w', 88:'x', 89:'y', 90:'z', 48:0, 49:1, 50:2, 51:3, 52:4, 53:5, 54:6, 55:7, 56:8, 57:9, 96:0, 97:1, 98:2, 99:3, 100:4, 101:5, 102:6, 103:7, 104:8, 105:9, 190:'.', 8:"delete", 37:"left", 39:"right", 91:"cmd", 9:"tab"}
  format: ''
  constructor: (inputType, @el) ->
    switch inputType
      when "phone" then @formatForPhone()
      when "date" then @formatForDate()
      when "numbers" then @formatForNumbers("decimals")
      when "numbers-with-decimals" then @formatForNumbers("decimals")

  formatForPhone: () ->
    @format = "phone"
    #user defined placeholder over-rides a default
    @el.placeholder = "000-000-0000" if @el.placeholder is ""
    @el.onkeydown = (e) =>
      key = @keyMap[e.which]
      if Number(key) or key is 0 or key is "delete" or key is "left" or key is "right" or key is "tab"
        if (@el.value.length is 3 || @el.value.length is 7) && key isnt "delete"
          #append a slash when adding text and reaching a 2 or 5 length
          @el.value = "#{@el.value}-"
          return true
        else if @el.value.length is 12 and key isnt "delete" and key isnt "tab"
          #length has reached maximum date length, so stop
          return false
        else return true
      else if e.metaKey
        @_allowDefaults(e)
      #return false if key is not accepted.
      else return false
      
  formatForDate: () ->
    @format = "date"
    #user defined placeholder over-rides a default
    @el.placeholder = "01/01/1971" if @el.placeholder is ""
    @el.onkeydown = (e) =>
      key = @keyMap[e.which]
      if Number(key) or key is 0 or key is "delete" or key is "left" or key is "right" or key is "tab"
        if (@el.value.length is 2 || @el.value.length is 5) && key isnt "delete"
          #append a slash when adding text and reaching a 2 or 5 length
          @el.value = "#{@el.value}/"
          return true
        else if @el.value.length is 10 and key isnt "delete" and key isnt "tab"
          #length has reached maximum date length, so stop
          return false
        else return true
      else if e.metaKey
        @_allowDefaults(e)
      #return false if key is not accepted.
      else return false

    #validate the date on blur
    @el.onblur = (e) =>
      @_validateDate()

  formatForNumbers: (options = "") ->
    if options is "decimals" then @format = "numbers" else @format = "numbersWithDecimals"
    @el.onkeydown = (e) =>
      key = @keyMap[e.which]
      if Number(key) or key is "delete" or key is "left" or key is "right" or key is "tab"
        return true
      else if e.metaKey 
        @_allowDefaults(e)
      else if options is "decimals"
        if key is "."
          if /\./.test(@el.value) is false
            return true
          else return false
        else return false
      else return false
    @el.onblur = (e) =>
      @_validateDate()

  _validateDate: ->
    text = @el.value
    month = Number(text.substring(0,2))
    date = text.substring(3,5)
    year = text.substring(6)

    daysInMonths = {1:31, 2:29, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31}
    if month > 12
      alert("There isn't a month higher than 12")
      @_modifyData("clear")
    if date > daysInMonths[month]
      alert("That is not a valid day for this month")
      @_modifyData("clear")

  _validatePaste: (previousText) ->
    if @format is "numbers"
      #Check if pasted data has anything besides numbers in it
      if /[^0-9]/.test(@el.value) is false
        @_modifyData("reset", previousText) 
    if @format is "date" or @format is "phone"
      @_modifyData("reset", previousText)

  _modifyData: (modifyType, resetText = "") ->
    #leave focus so we can set the value
    @el.blur()
    switch modifyType
      when "reset" then @el.value = resetText
      when "clear" then @el.value = ""
    #Refocus after 1 ms (without the timeout, setting the value fails)
    setTimeout((=>
      @el.focus()
    ),2)

  _allowDefaults: (e, format) ->
    if @keyMap[e.which] is "v"
      previousText = @el.value
      @_validatePaste(previousText)


document.addEventListener "DOMContentLoaded", ->
  arrayOfInputElements = document.getElementsByTagName('input')
  for element in arrayOfInputElements
    inputType = element.getAttribute('data-format')
    new window.MakeUp(inputType, element)