###
 @{#}Object:        MakeUp.Email
 @{#}Version:       1.1.1
 @{#}Last Updated:  sept 12, 2013
 @{#}Purpose:       Provide email formatting to input fields
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

class MakeUp.Email extends MakeUp

  #
  ## constructor: ->

  constructor: (@el) ->
    @format = "email"
    @setPlaceholder("user@domain.com")
    @bindEvents()

  #
  ## keydown: ->

  keydown: (key) ->
    @shouldApply = true
    @applyChar(key)

  #
  ## validate: ->

  validate: ->
    if /.*\@.*\.(com|org|net)/.test(@el.value) is false and @el.value.length > 0
      alert('The format you entered is not a valid email format. Please try again')
      @el.value = ''

  #
  ## alwaysAcceptableKeys: ->

  alwaysAcceptableKeys: ->
    [91, 16, 9, 8, 46, 37, 38, 39, 40, shiftKey]
