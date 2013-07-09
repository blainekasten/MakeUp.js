describe 'Phone format', ->
  beforeEach ->
    @e = $.Event("keydown")
    @e.which = 49
    phoneElement = document.createElement "input"
    phoneElement.data-format = "phone"
    document.documentElement.appendChild phoneElement
    @makeup = new MakeUp("phone", phoneElement)
    spyOn(@makeup, 'formatForPhone')

  it 'should be defined', ->
    expect(@makeup).toBeDefined()

  it 'should have a phone format method', ->
    expect(@makeup.formatForPhone).toBeDefined()

  it 'should call formatForPhone', ->
    p = document.createElement "input"
    @makeup.constructor("phone", p)
    expect(@makeup.formatForPhone).toHaveBeenCalled()
  
  it 'should set the format variable to "phone"', ->
    expect(@makeup.format).toBe("phone")

  it 'should have a placeholder of 000-000-0000 when there is no placeholder', ->
    expect(@makeup.el.placeholder).toBe("000-000-0000")

  it 'should not override a placeholder that is manually set', ->
    phoneElement = document.createElement "input"
    phoneElement.data-format = "phone"
    phoneElement.placeholder = "999-867-5309"
    document.documentElement.appendChild phoneElement
    makeup = new MakeUp("phone", phoneElement)
    expect(makeup.el.placeholder).toBe("999-867-5309")

  it 'should allow numbers', ->
    keyArray = [48,49,50,51,52,53,54,55,56,57,96,97,98,99,100,101,102,103,104,105]
    for key in keyArray
      @makeup.el.value = "111"
      @e.which = key
      $(@makeup.el).trigger(@e)
      expect(@makeup.el.value).toEqual("111-")

  it 'should append a "-" when the length is 3', ->
    @makeup.el.value = "111"
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("111-")
  
  it 'should append a "-" when the length is 7', ->
    @makeup.el.value = "111-111"
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("111-111-")

  it 'should not accept more characters when length is 12', ->
    @makeup.el.value = "111-111-1111"
    e = $.Event("keydown")
    e.which = 49
    $(@makeup.el).trigger(e)
    expect(@makeup.el.value).toEqual("111-111-1111")

  it 'should call _allowDefaults when the metaKey is pressed', ->
    spyOn(@makeup, 'allowDefaults')
    @e.which = null #set the key to null so it passes other if statements
    @e.metaKey = true
    $(@makeup.el).trigger(@e)
    expect(@makeup.allowDefaults).toHaveBeenCalledWith(@e)

  it 'should not accept letters entered', -> 
    @makeup.el.value = "111"
    @e.which = 44 
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toEqual("111")

