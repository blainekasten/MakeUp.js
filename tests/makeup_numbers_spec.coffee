describe 'Date format -', ->
  beforeEach ->
    @e = $.Event("keydown")
    nEl = document.createElement "input"
    nEl.data-format = "numbers"
    document.documentElement.appendChild nEl
    @makeup = new MakeUp("numbers", nEl)
    spyOn(@makeup, 'formatForNumbers')

  it 'should be defined', ->
    expect(@makeup).toBeDefined()

  it 'should have a numbers format function', ->
    expect(@makeup.formatForNumbers).toBeDefined()

  it 'should call formatForNumbers', ->
    n = document.createElement "input"
    @makeup.constructor("numbers", n)
    expect(@makeup.formatForNumbers).toHaveBeenCalled()

  it 'should set the format variable to "numbers"', ->
    expect(@makeup.format).toBe("numbers")

  it 'should call allowDefaults when the metaKey is pressed', ->
    spyOn(@makeup, 'allowDefaults')
    @e.metaKey = true
    $(@makeup.el).trigger(@e)
    expect(@makeup.allowDefaults).toHaveBeenCalledWith(@e)
