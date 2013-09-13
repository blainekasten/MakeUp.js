describe 'MakeUp', ->
  beforeEach ->
    @input = document.createElement 'input'
    @makeup = new MakeUp.Phone(@input)

  # Testing of these methods happens on the individual extensions
  describe 'has these methods:', ->
    it 'bindEvents', ->
      expect(@makeup.bindEvents).toBeDefined()
    it 'modifyData', ->
      #This is going to be removed
      expect(@makeup.modifyData).toBeDefined()
    it 'setPlaceholder', ->
      expect(@makeup.setPlaceholder).toBeDefined()
    it 'acceptedCharsAtIndex', ->
      expect(@makeup.acceptedCharsAtIndex).toBeDefined()
    it 'acceptedChars', ->
      expect(@makeup.acceptedChars).toBeDefined()
    it 'insertCharsAtIndex', ->
      expect(@makeup.insertCharsAtIndex).toBeDefined()
    it 'applyChar', ->
      expect(@makeup.applyChar).toBeDefined()
    it 'alwaysAcceptableKeys', ->
      expect(@makeup.alwaysAcceptableKeys).toBeDefined()
    it 'keydown', ->
      expect(@makeup.keydown).toBeDefined()
    it 'keyup', ->
      expect(@makeup.keyup).toBeDefined()
    it 'blur', ->
      expect(@makeup.blur).toBeDefined()
    it 'validate should not exist here', ->
      makeup = new MakeUp(@input)
      expect(makeup.validate).toBeUndefined()

  describe 'constructor', ->
    it 'should call setPlaceHolder', ->
      spyOn(@makeup, 'setPlaceholder')
      @makeup.constructor(@input)
      expect(@makeup.setPlaceholder).toHaveBeenCalled()

    it 'should call bindEvents', ->
      spyOn(@makeup, 'bindEvents')
      @makeup.constructor(@input)
      expect(@makeup.bindEvents).toHaveBeenCalled()

    it 'should set the passed element as a global element', ->
      @makeup.constructor(@input)
      expect(@makeup.el).toBe @input

  describe 'bindEvents', ->
    #bindEvents has already been called by constructor
    beforeEach ->
      @event = $.Event('keydown')
      @event.which = 57 #9

    it 'should set the global key onkeydown', ->
      $(@makeup.el).trigger(@event)
      expect(@makeup.key).toBe 9

    it 'should call @keydown onkeydown', ->
      spyOn(@makeup, 'keydown')
      $(@makeup.el).trigger(@event)
      expect(@makeup.keydown).toHaveBeenCalled()

    it 'should not do anything for acceptable keys', ->
      event = $.Event('keydown')
      event.which = 91
      spyOn(@makeup, 'keydown')
      $(@makeup.el).trigger(event)
      expect(@makeup.keydown).not.toHaveBeenCalled()

    it 'should call @keyup onkeyup', ->
      event = $.Event('keyup')
      event.which = 57
      spyOn(@makeup, 'keyup')
      $(@makeup.el).trigger(event)
      expect(@makeup.keyup).toHaveBeenCalled()

    it 'should call @blur onblur', ->
      event = $.Event('blur')
      spyOn(@makeup, 'blur')
      $(@makeup.el).trigger(event)
      expect(@makeup.blur).toHaveBeenCalled()

  describe 'setPlaceholder', ->

    it 'should set the placeholder off the global definition', ->
      @makeup.setPlaceholder()
      expect(@makeup.el.placeholder).toBe '000-000-0000'

    it 'should not set the placeholder if it already has one', ->
      @makeup.el.placeholder = 'yy'
      @makeup.setPlaceholder()
      expect(@makeup.el.placeholder).toBe 'yy'

  describe 'acceptedCharsAtIndex', ->
    beforeEach ->
      @makeup.el.value = ''

    it 'should set the shouldApply variable to true when the index is right', ->
      @makeup.key = 3
      @makeup.acceptedCharsAtIndex(/[0-9]/, '0-1')
      expect(@makeup.shouldApply).toBeTruthy()

    it 'should set tthe shouldApply var to false when the index isnt right', ->
      @makeup.key = 3
      @makeup.acceptedCharsAtIndex(/[0-9]/, '2')
      expect(@makeup.shouldApply).toBe false

    it 'should set the shouldApply var to false when the regex doesnt pass', ->
      @makeup.key = 'A'
      @makeup.acceptedCharsAtIndex(/[0-9]/, '1')
      expect(@makeup.shouldApply).toBe false

  describe 'acceptedChars', ->
    beforeEach ->
      @makeup.el.value = ''

    it 'should set the shouldApply var to true when the regex passes', ->
      @makeup.key = 3
      @makeup.acceptedChars(/[0-9]/)
      expect(@makeup.shouldApply).toBeTruthy() 

    it 'should set the shouldApply var to false when the regex fails', ->
      @makeup.key = 'A' 
      @makeup.acceptedChars(/[0-9]/)
      expect(@makeup.shouldApply).toBe false

  describe 'insertCharsAtIndex', ->
    beforeEach ->
      @makeup.el.value = ''

    it 'should insert the specified character at the correct index', ->
      @makeup.insertCharsAtIndex('hello', 0)
      expect(@makeup.el.value).toBe 'hello'

  describe 'applyChar', ->
    beforeEach ->
      @makeup.key = 3
      @makeup.shouldApply = true
      @makeup.el.value = ''

    it 'should not apply a character if the limit is reached', ->
      @makeup.el.value = '000-000-0000'
      @makeup.applyChar()
      expect(@makeup.el.value).toBe '000-000-0000'
 
    it 'should not apply a character if shouldApply is false', ->
      @makeup.shouldApply = false
      @makeup.applyChar()
      expect(@makeup.el.value).toBe ''

    it 'should append the key if everything passes', ->
      @makeup.applyChar()
      expect(@makeup.el.value).toBe '3'

  describe 'blur', ->
    it 'should call validate', ->
      spyOn(@makeup, 'validate')
      @makeup.blur()
      expect(@makeup.validate).toHaveBeenCalled()
