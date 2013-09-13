describe 'MakeUp.Numbers', ->
  beforeEach ->
    input = document.createElement 'input'
    @makeup = new MakeUp.Numbers(input)

  it 'should set its format to numbers', ->
    expect(@makeup.format).toBe 'numbers'

  it 'should only allow characters on 0-9 keys', ->
    arr = [0,1,2,3,4,5,6,7,8,9]
    for num in arr
      @makeup.key = num
      @makeup.keydown()
      expect(@makeup.shouldApply).toBe(true)

  it 'should not allow letters to post', ->
    arr = 'abcdefghijklmnopqrstuvwxyz,./;[]+_)(*&^%$#@!'
    for l in arr
      @makeup.key = l
      @makeup.keydown()
      expect(@makeup.shouldApply).toBe(false)

  it 'should have a validate function', ->
    expect(@makeup.validate).toBeDefined()

  it 'validate function shouldnt allow anything non-numeric', ->
    @makeup.el.value = '1a2b'
    spyOn(window, 'alert').andReturn(false)
    @makeup.validate()
    expect(@makeup.el.value).toBe ''
