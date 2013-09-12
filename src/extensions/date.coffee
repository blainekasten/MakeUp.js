###
 @{#}Object:        MakeUp.Date
 @{#}Version:       1.1.0
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide date formatting to input fields
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

class MakeUp.Date extends MakeUp

  #
  ## Constructor 
  #
  constructor: (@el) ->
    @setPlaceholder('01/31/1971')
    @format = 'date'
    @limit = (10)
    @bindEvents()

  keydown: (key) ->
    @acceptedCharsAtIndex(/[0-9]/, '0-1,3-4,6-10', key)
    @checkLimit()
    @applyChar(key)

  keyup: (key) ->
    @easeUse(key)
    unless key is 'delete'
      @insertCharsAtIndex('/', [2,5])

  #
  ## validate()
  ## Function { Makes sure the date entered is valid }
  #
  validate: ->
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

  #
  ## Conditionals for how each key should react
  #
  easeUse: (key) ->
    val = @el.value
    if val.length is 1
      if /[2-9]/.test(key) 
        @el.value = "0#{val}"
      else if key is '/'
        @el.value = "0#{val}/"

    else if val.length is 2
      if val is '13'
        @el.value = "0#{val[0]}/#{val[1]}"