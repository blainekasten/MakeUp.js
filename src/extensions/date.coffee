###
 @{#}Object:        MakeUp.Date
 @{#}Version:       1.1.1
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide date formatting to input fields
 @{#}Author:        Blaine Kasten (http://www.github.com/blainekasten)
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

  format: 'date'
  limit: 10
  placeholder: '01/31/1971'

  #
  ## keydown: ->

  keydown: ->
    @acceptedCharsAtIndex(/[0-9]/, '0-1,3-4,6-10')
    @applyChar()

  #
  ## keyup: ->

  keyup: ->
    @easeUse()
    @insertCharsAtIndex('/', [2,5])

  #
  ## validate: ->

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
      @el.value = ''
    else if date > daysInMonths[month]
      alert("That is not a valid day for this month")
      @el.value = ''
    else if /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/.test(@el.value) is false and @el.value.length > 0
      alert("The date format is not correct. It must be mm/dd/yyyy.")
      @el.value = ''

  #
  ## easeUse: ->
  ## Conditionals for how keys should react at different indexes

  easeUse: ->
    val = @el.value
    if val.length is 1
      if /[2-9]/.test(@key) 
        @el.value = "0#{val}"
      else if @key is '/'
        @el.value = "0#{val}/"

    else if val.length is 2
      if val is '13'
        @el.value = "0#{val[0]}/#{val[1]}"

    if val.length is 8 
      @fixYear()

  #
  ## fixYear: ->
  ## Appends the year for the user
  
  fixYear: ->
    splitVal = @el.value.split('/')
    year = splitVal[2]
    unless year is '19' or year is '20'
      currYear = Number(String(new window.Date().getFullYear()).substring(2))
      if year > currYear
        append = 19
      else 
        append = 20
      @el.value = "#{splitVal[0]}/#{splitVal[1]}/#{append}#{year}"
