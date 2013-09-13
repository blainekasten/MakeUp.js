###
 @{#}Object:        MakeUp.Phone
 @{#}Version:       1.1.1
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide phone formatting to input fields
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

class MakeUp.Phone extends MakeUp

  format:  "phone"
  placeholder: '000-000-0000'
  limit: 12

  #
  ## keydown: ->

  keydown: ->
    @acceptedCharsAtIndex(/[0-9]/, '0-2,4-6,8-12')
    @applyChar()

  #
  ## keyup: ->

  keyup: ->
    unless @key is 'delete'
      @insertCharsAtIndex('-', [3,7])

  #
  ## validate: ->

  validate: ->
    if /[0-9]{3}-[0-9]{3}-[0-9]{4}/.test(@el.value) is false and @el.value.length > 0
      alert("The phone number format you entered is not correct.")
      @el.value = ''
