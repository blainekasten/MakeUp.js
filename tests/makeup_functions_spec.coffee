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
      @makeup.el.value = 124532
      spyOn(@makeup,"modifyData")
      @makeup.validatePaste("1234")
      expect(@makeup.modifyData).not.toHaveBeenCalled()

    it 'does call reset if value is not just numbers after paste', ->
      @makeup.format = "numbers"
      @makeup.el.value = "1234Ab213"
      spyOn(@makeup,"modifyData")
      @makeup.validatePaste("1234")
      expect(@makeup.modifyData).toHaveBeenCalledWith("reset", "1234") 
