describe 'MakeUp.State', ->
  beforeEach ->
    input = document.createElement 'input'
    @makeup = new MakeUp.State(input)

  it 'should set the placeholder to MN', ->
    expect(@makeup.el.placeholder).toBe 'MN'

  it 'should have a format of state', ->
    expect(@makeup.format).toBe 'state'

  it 'should have limit of 2', ->
    expect(@makeup.limit).toBe 2

  it 'should accept capital chars', ->
    chars = ['A','B','Z','Q']
    for char in chars
      @makeup.key = char
      @makeup.keydown()
      expect(@makeup.shouldApply).toBeTruthy()

  it 'should not accept lowercase chars or other chars', ->
    chars = [1, '.', ',', ' ']
    for char in chars
      @makeup.key = char
      @makeup.keydown()
      expect(@makeup.shouldApply).toBe false

  it 'should validate to be just two uppercase chars', ->
    values = ['AZ', 'MN', 'NM']
    for value in values
      @makeup.value = value
      @makeup.validate()
      expect(@makeup.value).toBe value

  it 'should fail 3+ chars, non caps, and numbers', ->
    values = ['az', 23, 'a', '>2']
    spyOn(window, 'alert').andReturn false
    for value in values
      @makeup.el.value = value
      @makeup.validate()
      expect(@makeup.el.value).toBe ''

  it 'should upeercase on each char', ->
    @makeup.key = 'a'
    @makeup.keydown()
    expect(@makeup.key).toBe 'A'
