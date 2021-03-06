###
 @{#}Object:        MakeUp.State
 @{#}Version:       1.1.1
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide state formatting to input fields
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

class MakeUp.State extends MakeUp

  placeholder: 'MN'
  format: 'state'
  limit: 2

  #
  ## keydown: ->

  keydown: ->
    @key = @uppercaseChar(@key)
    @acceptedChars(/[A-Z]/)
    @applyChar()

  #
  ## validate: ->

  validate: ->
    if /[A-Z]{2}/.test(@el.value) is false and @el.value.length > 0
      alert('The format for this field needs to be "MN"')
      @el.value = ''

  #
  ## uppercaseChar: ->
  ## This will uppercase the users entered key.

  uppercaseChar: ->
    if /[a-zA-Z]/.test(@key) and @key != undefined
      @key.toUpperCase()
