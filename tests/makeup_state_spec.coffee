describe 'State formatter', ->
  beforeEach ->
    @e = $.Event("keydown")
    @e.which = 65
    sEl = document.createElement "input"
    sEl.data-format = "state"
    document.documentElement.appendChild sEl
    @makeup = new MakeUp("state", sEl)

  it 'should have a formatForState function', ->
    expect(@makeup.formatForState).toBeDefined()

  it 'should call formatForState upon initiation', ->
    d = document.createElement "input"
    spyOn(@makeup,"formatForState")
    @makeup.constructor("state", d)
    expect(@makeup.formatForState).toHaveBeenCalled()

  it 'should set the format variable to "state"', ->
    expect(@makeup.format).toBe("state")

  it 'should set the placeholder to MN', ->
    expect(@makeup.el.placeholder).toBe("MN")

  it 'should not over-ride a placeholder', ->
    @makeup.el.placeholder = "HA"
    @makeup.formatForState()
    expect(@makeup.el.placeholder).toBe("HA")

  it 'should autocapitalize letters', ->
    spyOn(String.prototype,"toUpperCase")
    $(@makeup.el).trigger(@e)
    expect(String.prototype.toUpperCase).toHaveBeenCalled()

  it 'should only accept letters', ->
    @e.which = 48
    spyOn(String.prototype,"toUpperCase")
    $(@makeup.el).trigger(@e)
    expect(String.prototype.toUpperCase).not.toHaveBeenCalled()

  it 'should store the current data in a variable when the metakey is pressed', ->
    @makeup.el.value = "abc"
    e = $.Event("keydown")
    e.metaKey = true
    $(@makeup.el).trigger(e)
    expect(@makeup.currVal).toBe("abc")

  it 'should call validate paste when the metakey is keyup', ->
    e = $.Event("keyup")
    e.metaKey = true
    spyOn(@makeup,"allowDefaults")
    $(@makeup.el).trigger(e)
    expect(@makeup.allowDefaults).toHaveBeenCalledWith(e)


