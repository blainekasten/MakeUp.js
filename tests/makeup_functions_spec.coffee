describe 'MakeUp functions -', ->
  beforeEach ->
    @e = $.Event("keydown")
    @e.which = 49
    el = document.createElement "input"
    el.data-format = "phone"
    document.documentElement.appendChild el
    @makeup = new MakeUp("numbers", el)

  describe 'validatePaste', ->
    it 'should be dfined', ->
      expect(@makeup.validatePaste).toBeDefined()

    it 'does not call reset if the value is all numbers', ->
      @makeup.format = "numbers"
      @makeup.el.value = "124532"
      spyOn(@makeup,"modifyData")
      @makeup.validatePaste("1234")
      expect(@makeup.modifyData).not.toHaveBeenCalled()

    it 'does call reset if value is not just numbers after paste', ->
      @makeup.format = "numbers"
      @makeup.el.value = "1234Ab213"
      spyOn(@makeup,"modifyData")
      @makeup.validatePaste("1234")
      expect(@makeup.modifyData).toHaveBeenCalledWith("reset", "1234") 

    it 'should call reset the input to previous text if format is date or phone', ->
      @makeup.format = "date"
      spyOn(@makeup,"modifyData")
      @makeup.validatePaste("03/29")
      expect(@makeup.modifyData).toHaveBeenCalledWith("reset", "03/29")

      @makeup.format = "phone"
      @makeup.validatePaste("333-")
      expect(@makeup.modifyData).toHaveBeenCalledWith("reset", "333-")

  describe 'modifyData', ->
    it 'should call blur on the element', ->
      spyOn(@makeup.el,"blur")
      @makeup.modifyData("reset", "123")
      expect(@makeup.el.blur).toHaveBeenCalled()

   it 'should set the el value to the previous text if modifyType is "reset"', ->
     @makeup.el.value = "abc"
     @makeup.modifyData("reset","123")
     expect(@makeup.el.value).toEqual("123")

   it 'should set the el value to "" if the modifyType is "clear"', ->
     @makeup.el.value = "123"
     @makeup.modifyData("clear")
     expect(@makeup.el.value).toEqual("")

   it 'should refocus on the element after a 300 ms timeout', ->
     jasmine.Clock.useMock()
     spyOn(@makeup.el,"focus")
     @makeup.modifyData("clear")
     jasmine.Clock.tick(301)
     expect(@makeup.el.focus).toHaveBeenCalled()
