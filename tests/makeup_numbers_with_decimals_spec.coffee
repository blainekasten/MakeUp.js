describe 'Date format -', ->
  beforeEach ->
    @e = $.Event("keydown")
    nEl = document.createElement "input"
    nEl.data-format = "numbers-with-decimals"
    document.documentElement.appendChild nEl
    @makeup = new MakeUp("numbers-with-decimals", nEl)
    spyOn(@makeup, 'formatForNumbers')

  it 'should be defined', ->
    expect(@makeup).toBeDefined()

  it 'should have a numbers format function', ->
    expect(@makeup.formatForNumbers).toBeDefined()

  it 'should call formatForNumbers', ->
    n = document.createElement "input"
    @makeup.constructor("numbers-with-decimals", n)
    expect(@makeup.formatForNumbers).toHaveBeenCalledWith("decimals")

  it 'should set the format variable to "numbersWithDecimals"', ->
    expect(@makeup.format).toBe("numbersWithDecimals")

  it 'should call allowDefaults when the metaKey is pressed', ->
    spyOn(@makeup, 'allowDefaults')
    @e.metaKey = true
    $(@makeup.el).trigger(@e)
    expect(@makeup.allowDefaults).toHaveBeenCalledWith(@e)
