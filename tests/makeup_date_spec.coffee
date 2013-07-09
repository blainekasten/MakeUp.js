describe 'Date format', ->
  beforeEach ->
    @e = $.Event("keydown")
    @e.which = 49
    dEl = document.createElement "input"
    dEl.data-format = "date"
    document.documentElement.appendChild dEl
    @makeup = new MakeUp("date", dEl)
    spyOn(@makeup, 'formatForDate')
    spyOn(@makeup, 'validateDate').andCallThrough()

  it 'should be defined', ->
    expect(@makeup).toBeDefined()

  it 'should have a date format function', ->
    expect(@makeup.formatForDate).toBeDefined()

  it 'should call formatForDate', ->
    d = document.createElement "input"
    @makeup.constructor("date", d)
    expect(@makeup.formatForDate).toHaveBeenCalled()

  it 'should set the format variable to "date"', ->
    expect(@makeup.format).toBe("date")

  it 'should have a placeholder 01/01/1971 when there is no placeholder', ->
    expect(@makeup.el.placeholder).toBe("01/01/1971")

  it 'should not override a placeholder that is manually set', ->
    dEl = document.createElement "input"
    dEl.data-format = "date"
    dEl.placeholder = "03/03/2012"
    document.documentElement.appendChild dEl
    makeup = new MakeUp("phone", dEl)
    expect(makeup.el.placeholder).toBe("03/03/2012")

  it 'should allow numbers', ->
    keyArray = [48,49,50,51,52,53,54,55,56,57,96,97,98,99,100,101,102,103,104,105]
    for key in keyArray
      @makeup.el.value = "02"
      @e.which = key
      $(@makeup.el).trigger(@e)
      expect(@makeup.el.value).toEqual("02/")

  it 'should append a "/" when the length is 2', ->
    @makeup.el.value = "02"
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("02/")

  it 'should append a "/" when the length is 5', ->
    @makeup.el.value = "02/02"
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("02/02/")
  
  it 'should not accept more characters when length is 12', ->
    @makeup.el.value = "02/02/2012"
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("02/02/2012")

  it 'should call allowDefaults when the metaKey is pressed', ->
    spyOn(@makeup, 'allowDefaults')
    e = $.Event('keydown')
    e.metaKey = true
    $(@makeup.el).trigger(e)
    expect(@makeup.allowDefaults).toHaveBeenCalledWith(e)

  it 'should not accept letters entered', -> 
    @makeup.el.value = "02"
    @e.which = 44 
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("02")

  it 'should call validateDate() on blur', ->
    $(@makeup.el).focus()
    $(@makeup.el).blur()
    expect(@makeup.validateDate).toHaveBeenCalled()

  describe 'validateDate()', ->

    it 'is defined', ->
      expect(@makeup.validateDate).toBeDefined()

    it 'alerts if the month is greater than 12', ->
      @makeup.el.value = "13/01/2013"
      spyOn(window,"alert")
      @makeup.validateDate()
      expect(alert).toHaveBeenCalled()

    it 'calls modifyData("clear") when the month is greater than 12', ->
      @makeup.el.value = "13/13/2013"
      spyOn(@makeup,"modifyData")
      @makeup.validateDate()
      expect(@makeup.modifyData).toHaveBeenCalledWith("clear")

    it 'alerts if the day is higher than it should be for the month', ->
      @makeup.el.value = '02/29/2013'
      spyOn(window,"alert")
      @makeup.validateDate()
      expect(alert).toHaveBeenCalled()

    it 'calls modifyData("Clear")when the day is higher than it should be for the month', ->
      @makeup.el.value = '02/29/2013'
      spyOn(@makeup,"modifyData")
      @makeup.validateDate()
      expect(@makeup.modifyData).toHaveBeenCalledWith("clear")
