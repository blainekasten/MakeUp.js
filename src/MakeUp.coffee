class window.MakeUp
  keyMap: {65:'a', 66:'b', 67:'c', 68:'d', 69:'e', 70:'f', 71:'g', 72:'h', 73:'i', 74:'j', 75:'k', 76:'l', 77:'m', 78:'n', 79:'o', 80:'p', 81:'q', 82:'r', 83:'s', 84:'t', 85:'u', 86:'v', 87:'w', 88:'x', 89:'y', 90:'z', 48:0, 49:1, 50:2, 51:3, 52:4, 53:5, 54:6, 55:7, 56:8, 57:9, 96:0, 97:1, 98:2, 99:3, 100:4, 101:5, 102:6, 103:7, 104:8, 105:9, 190:'.', 8:"delete", 37:"left", 39:"right", 91:"cmd", 9:"tab", 16:"shift"}
  format: ''
  constructor: (inputType, @el) ->
    switch inputType
      when "phone" then @formatForPhone()
      when "date" then @formatForDate()
      when "numbers" then @formatForNumbers()
      when "numbers-with-decimals" then @formatForNumbers("decimals")
      when "email" then @formatForEmail()

  formatForEmail: () ->
    @format = "email"
    @el.placeholder = "user@domain.com" if @el.placeholder is ""
    @el.onkeydown = (e) =>
      key = @keyMap[e.which]
      if (@el.value.length is 0)
        @el.value = "@"
        @el.setSelectionRange(0, -1)
      if (@shouldPlacePeriod is true)
        endIndex = @el.value.length
        @el.value += "."
        @el.setSelectionRange(endIndex, endIndex)
        @shouldPlacePeriod = false
      if (e.shiftKey)
        if (key is 2)
          atIndex = @el.value.indexOf("@")
          if @el.selectionStart is atIndex
            @el.setSelectionRange(atIndex+1, atIndex+1)
            @shouldPlacePeriod = true unless /\@.*\./.test(@el.value) is true
          return false
      if (key is ".")
        #make sure the rest is in line already
        if /.*\@.*\./.test(@el.value) is true
          end = @el.value.length
          @el.setSelectionRange(end, end)
          return false

      if key is "delete"
        @currVal = @el.value
    @el.onkeyup = (e) =>
      key = @keyMap[e.which]
      if (key is "delete")
        #if the delete key removes the @ symbol, reset
        if /\@/.test(@el.value) is false 
          unless @el.value is ""
            @modifyData("reset", @currVal) 
            index = @el.value.indexOf("@")
            @el.setSelectionRange(index, index)



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
        @allowDefaults(e)
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
        @allowDefaults(e)
      #return false if key is not accepted.
      else return false

    #validate the date on blur
    @el.onblur = (e) =>
      @validateDate()

  formatForNumbers: (options = "") ->
    if options is "decimals" then @format = "numbersWithDecimals" else @format = "numbers"
    @el.onkeydown = (e) =>
      key = @keyMap[e.which]
      if Number(key) or key is "delete" or key is "left" or key is "right" or key is "tab"
        return true
      else if e.metaKey 
        @allowDefaults(e)
      else if options is "decimals"
        if key is "."
          if /\./.test(@el.value) is false
            return true
          else return false
        else return false
      else return false

  validateDate: ->
    text = @el.value
    month = Number(text.substring(0,2))
    date = text.substring(3,5)
    year = text.substring(6)

    #Leap Year
    if year % 4 is 0
      februaryDays = 29
    else februaryDays = 28

    daysInMonths = {1:31, 2:februaryDays, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31}
    if month > 12
      alert("There isn't a month higher than 12")
      @modifyData("clear")
    if date > daysInMonths[month]
      alert("That is not a valid day for this month")
      @modifyData("clear")

  validatePaste: (previousText) ->
    if @format is "numbers"
      #Check if pasted data has anything besides numbers in it
      if /[^0-9]/.test(@el.value) is true
        @modifyData("reset", previousText) 
    if @format is "date" or @format is "phone"
      @modifyData("reset", previousText)

  modifyData: (modifyType, resetText = "") ->
    #leave focus so we can set the value
    @el.blur()
    switch modifyType
      when "reset" then @el.value = resetText
      when "clear" then @el.value = ""
    #Refocus after 1 ms (without the timeout, setting the value fails)
    setTimeout((=>
      @el.focus()
    ),300)
    

  allowDefaults: (e, format) ->
    if @keyMap[e.which] is "v"
      previousText = @el.value
      @validatePaste(previousText)

document.addEventListener "DOMContentLoaded", ->
  arrayOfInputElements = document.getElementsByTagName('input')
  for element in arrayOfInputElements
    inputType = element.getAttribute('data-format')
    new window.MakeUp(inputType, element)
