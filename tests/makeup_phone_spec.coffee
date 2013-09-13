describe 'MakeUp.Phone', ->
  beforeEach ->
    input = document.createElement 'input'
    @makeup = new MakeUp.Phone(input)

  it 'should set the placeholder to 000-000-0000', ->
    expect(@makeup.el.placeholder).toBe '000-000-0000'

  it 'should have a format of phone', ->
    expect(@makeup.format).toBe 'phone'

  it 'should have a limit of 12 chars', ->
    expect(@makeup.limit).toBe 12

  it 'should accept 0-9 chars at indexes 0-2,4-6,8-12', ->
    strs = ['3205872910', '4028418175', '1118675309']
    for str in strs
      for char in str
        @makeup.key = char
        @makeup.keydown()
        expect(@makeup.shouldApply).toBe true
        @makeup.keyup()

  it 'inserts - at index 3', ->
    @makeup.el.value = '333'
    @makeup.el.key = 2
    @makeup.keyup()
    expect(@makeup.el.value).toBe '333-'

  it 'allows a format of 402-841-8175', ->
    strs = ['320-587-2910', '402-841-8175', '111-867-5309']
    for str in strs
      @makeup.el.value = str
      @makeup.validate()
      expect(@makeup.el.value).toBe str

  it 'should not accept formats of non xxx-xxx-xxxx', ->
    strs = ['3205872910', '4028-841-175', '111.867.5309']
    spyOn(window, 'alert').andReturn(false)
    for str in strs
      @makeup.el.value = str
      @makeup.validate()
      expect(@makeup.el.value).not.toBe str
