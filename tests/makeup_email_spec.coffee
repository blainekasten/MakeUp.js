describe 'MakeUp.Email', ->
  beforeEach ->
    input = document.createElement 'input'
    @makeup = new MakeUp.Email(input)

  it 'should accept any character', ->
    chars = ['a',',','@','%','&',1,9]
    for char in chars
      @makeup.key = char
      @makeup.keydown()
      expect(@makeup.shouldApply).toBe true

  it 'should pass validation on blainekastne@gmail.com', ->
    @makeup.el.value = 'blainekasten@gmail.com'
    @makeup.validate()
    expect(@makeup.el.value).toBe 'blainekasten@gmail.com'

  it 'should fail validation if the @ symbol is missing, if the period is missing, or the extension isnt correct', ->
    emails = ['blaine2gmail.com', 'blaiune@gmailcom', 'blaine@gmail.co']
    spyOn(window, 'alert').andReturn(true)
    for email in emails
      @makeup.el.value = email
      @makeup.validate()
      expect(@makeup.el.value).toBe ''
