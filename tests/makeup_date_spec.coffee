describe 'MakeUp.Date', ->
  beforeEach ->
    input = document.createElement 'input'
    @makeup = new MakeUp.Date(input)

  it 'should set the placeholder to 01/31/1971', ->
    expect(@makeup.el.placeholder).toBe '01/31/1971'

  it 'should have a format of date', ->
    expect(@makeup.format).toBe 'date'

  it 'should have limit of 10', ->
    expect(@makeup.limit).toBe 10

  it 'should accept 0-9 chars at indexes 0-1,3-4,6-10', ->
    strs = ['03291990', '1201990', '12292010']
    for str in strs
      for char in str
        @makeup.key = char
        @makeup.keydown()
        expect(@makeup.shouldApply).toBe true
        @makeup.keyup()

  it 'should only not allow non-numeric keys', ->
    arr = ['a',',','#','*','~',' ']
    for num in arr
      @makeup.el.value = ''
      @makeup.key = num
      @makeup.keydown()
      expect(@makeup.shouldApply).toBe false 

  it 'should call easeUse on keyup', ->
    spyOn(@makeup, 'easeUse')
    @makeup.keyup()
    expect(@makeup.easeUse).toHaveBeenCalled()

  it 'should insert /s at indexes 2', ->
    @makeup.el.value = '02'
    @makeup.key = 1
    @makeup.keyup()
    expect(@makeup.el.value).toBe '02/'

  it 'should insert /s at indexes 5', ->
    @makeup.el.value = '02/02'
    @makeup.key = 1
    @makeup.keyup()
    expect(@makeup.el.value).toBe '02/02/'

  it 'should validate month not being greater than 13', ->
    @makeup.el.value = '13/29/1990'
    spyOn(window, 'alert')
    @makeup.validate()
    expect(window.alert).toHaveBeenCalledWith("There isn't a month higher than 12")

  it 'should validate february for leap year', ->
    @makeup.el.value = '02/29/1997' #not leap year
    spyOn(window, 'alert')
    @makeup.validate()
    expect(window.alert).toHaveBeenCalledWith("That is not a valid day for this month")

  it 'should pass the 01/31/1990 format', ->
    @makeup.el.value = '01/31/1990'
    spyOn(window, 'alert')
    @makeup.validate()
    expect(window.alert).not.toHaveBeenCalled()

  it 'should call fixYear when the length is 8', ->
    spyOn(@makeup, 'fixYear')
    @makeup.el.value = '01/02/29'
    @makeup.easeUse()
    expect(@makeup.fixYear).toHaveBeenCalled()

  it 'should not change the year then the first 2 characters are 19 or 20', ->
    arr = ['19', 20]
    for year in arr
      @makeup.el.value = "01/01/#{year}"
      @makeup.fixYear()
      expect(@makeup.el.value).toBe "01/01/#{year}"

  it 'should append 19 when the first 2 characters of the year are greater than the currYears last 2 digits', ->
    currYear = Number(String(new window.Date().getFullYear()).substring(2)) + 1
    @makeup.el.value = "01/01/#{currYear}"
    @makeup.fixYear()
    expect(@makeup.el.value).toBe "01/01/19#{currYear}"

  it 'should append 19 when the first 2 characters of the year are less than the currYears last 2 digits', ->
    currYear = Number(String(new window.Date().getFullYear()).substring(2)) - 1
    @makeup.el.value = "01/01/#{currYear}"
    @makeup.fixYear()
    expect(@makeup.el.value).toBe "01/01/20#{currYear}"
