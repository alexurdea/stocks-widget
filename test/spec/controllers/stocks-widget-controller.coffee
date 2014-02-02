describe 'StocksWidgetCtrl controller', ->
  scope = null
  StocksWidgetCtrl = null
  portfolio = null
  stocks = null
  $controller = null
  stock = 
    symbol: 'GOOG',
    price: '100',
    activity: '+15%'

  beforeEach module 'testApp'

  beforeEach inject (_$controller_, $rootScope) ->
    scope = $rootScope.$new()
    $controller = _$controller_

  describe 'initializing', ->
    
    describe 'the mode', ->
      
      it 'should be `search` if there is nothing saved in portfolio', ->
        portfolio =
          getStocks: -> []

        StocksWidgetCtrl = $controller 'StocksWidgetCtrl',
          '$scope': scope
          portfolio: portfolio
        
        expect(scope.mode).toBe 'search'

      it 'should be `portfolio` if there are items in portfolio', ->
        portfolio =
          getStocks: -> [1, 2, 3]

        StocksWidgetCtrl = $controller 'StocksWidgetCtrl',
          '$scope': scope
          portfolio: portfolio
        
        expect(scope.mode).toBe 'portfolio'

  describe 'after init', ->
    beforeEach ->
      portfolio =
        getStocks: -> []
        saveStock: -> []
        deleteStock: -> []

      StocksWidgetCtrl = $controller 'StocksWidgetCtrl',
          '$scope': scope
          portfolio: portfolio

    describe 'when a stock is added', ->
      beforeEach ->
        scope.mode = 'search'
        scope.searchItem = 'GOOG'
        scope.addStock stock

      it 'should display a message when a stock is added', ->
        expect(scope.message).toBe 'GOOG added to your portfolio'

      it 'should reset the search input', ->
        expect(scope.result).toBe null      

    it 'should display a message when a stock is removed', ->
      scope.mode = 'portfolio'
      scope.removeStock stock
      expect(scope.message).toBe 'GOOG removed from your portfolio'