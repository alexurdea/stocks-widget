describe 'stocks-table directive', ->
  scope = null
  el = null

  beforeEach module 'testApp'
  beforeEach inject ($rootScope, $compile, $templateCache) ->
    scope = $rootScope.$new()
    scope.data = [
      {
        symbol: 'GOOG'
        price: '1000.20'
        activity: '+0.8%'
      },
      {
        symbol: 'YHOO'
        price: '8000.10'
        activity: '-0.3%'        
      }
    ]

    # this is a hack to get the template in tests when it requires an AJAX call
    # (when the templates are not already compiled)
    directiveTemplate = null
    req = new XMLHttpRequest()
    req.onload = () ->
      directiveTemplate = this.responseText

    # Using `false` as the third parameter to open() makes the operation synchronous.
    req.open 'get', '../../app/views/stocks-table.html', false
    req.send()
    $templateCache.put 'views/stocks-table.html', directiveTemplate

    el = $compile(angular.element('<div stocks-table stocks="data"></div>'))(scope);
    scope.$digest()

  it 'should grab the data from the param and display it as a table', ->
    tr = el.find('tbody').find('tr')
    expect(tr.length).toBe 2
    
    # check first row
    cells = angular.element(tr[0]).find 'td'
    expect(cells[1].innerHTML).toBe 'GOOG'
    expect(cells[2].innerHTML).toBe '1000.20'
    expect(cells[3].innerHTML).toBe '+0.8%'

    # check second row
    cells = angular.element(tr[1]).find 'td'
    expect(cells[1].innerHTML).toBe 'YHOO'
    expect(cells[2].innerHTML).toBe '8000.10'
    expect(cells[3].innerHTML).toBe '-0.3%'
