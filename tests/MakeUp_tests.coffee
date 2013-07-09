describe 'MakeUp Phone', () ->
  beforeEach () ->
    phoneElement = document.createElement "input"
    phoneElement.data-format = "phone"
    document.documentElement.appendChild phoneElement
    @makeup = new MakeUp("phone", phoneElement)

    it 'should be defined', () ->
      expect(@makeup).toBeDefined()
