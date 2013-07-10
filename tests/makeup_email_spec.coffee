describe 'Email format', ->
  beforeEach ->
    @e = $.Event("keydown")
    @e.which = 49
    eEL = document.createElement "input"
    eEL.data-format = "email"
    document.documentElement.appendChild eEL
    @makeup = new MakeUp("email", eEL)

  it 'should have a formatForEmail function', ->
    spyOn(@makeup,"formatForEmail")
    expect(@makeup.formatForEmail).toBeDefined()

  it 'should call formatForEmail automatically', ->
    d = document.createElement "input"
    spyOn(@makeup,"formatForEmail")
    @makeup.constructor("email", d)
    expect(@makeup.formatForEmail).toHaveBeenCalled()

  it 'should set the format variable to "email"', ->
    expect(@makeup.format).toBe("email")

  it 'should set the placeholder if none is defined', ->
    expect(@makeup.el.placeholder).toBe("user@domain.com")

  it 'should not over-ride a manually set placeholder', ->
    el = document.createElement "input"
    el.placeholder = "test"
    makeup = new MakeUp("email", el)
    expect(makeup.el.placeholder).toBe("test")

  it 'should place the @ symbol in the value if a key is pressed when the field is empty', ->
    @makeup.el.value = ""
    $(@makeup.el).trigger(@e)
    expect(@makeup.el.value).toBe("@")

  it 'should keep a storage of the current text when hittting delete', ->
    @e.which = 8
    @makeup.el.value = "hey"
    $(@makeup.el).trigger(@e)
    expect(@makeup.currVal).toBe("hey")

  it 'should undo the delete if the delete removes the @', ->
    @makeup.currVal = "user@mango.com"
    @makeup.el.value = "user"
    e = $.Event("keyup")
    e.which = 8
    spyOn(@makeup,"modifyData")
    $(@makeup.el).trigger(e)
    expect(@makeup.modifyData).toHaveBeenCalledWith("reset", "user@mango.com")
