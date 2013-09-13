###
 @{#}Object:        MakeUp.Numbers
 @{#}Version:       1.1.1
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

  format: 'numbers'

  #
  ## constructor: ->

  constructor: (@el) ->
    @bindEvents()

  #
  ## keydown: ->

  keydown: () ->
    @shouldApply = false
    @acceptedChars(/[0-9]/)
    @applyChar()

  #
  ## validate: ->

  validate: ->
    if /^[0-9]+$/.test(@el.value) is false and @el.value.length > 0
      alert('This field will only accept numbers.')
      @el.value = ''
