describe 'portfolio service', ->
  portfolio = null
  stock =
    symbol: 'YHOO'
    price: '120'
    activity: '+5%'
    $$hashKey: '00C'
  stock2 =
    symbol: 'GOOG'
    price: '121'
    activity: '+15%'
    $$hashKey: '00D'

  beforeEach module 'testApp'

  beforeEach inject (_portfolio_) ->
    portfolio = _portfolio_
    portfolio.getStocks()
  
  afterEach ->
    localStorage.removeItem 'stocks'


  describe 'saveStock', ->
    savedStock = null
    savedResult = null

    beforeEach ->
      savedResult = portfolio.saveStock stock
      savedStock = JSON.parse(localStorage.getItem('stocks'))[stock.symbol]


    it 'should work properly', ->
      expect(savedStock.symbol).toBe stock.symbol


    it 'should delete the $$hashKey when saving to localStorage', ->
      expect(savedStock.$$hashKey).toBe undefined


    it 'should return an array of stocks', ->
      expect(savedResult).toEqual [stock]


  describe 'deleteStock', ->
    deleteResult = null

    beforeEach ->
      portfolio.saveStock stock
      portfolio.saveStock stock2
      deleteResult = portfolio.deleteStock stock.symbol
      # stock2 is the remaining one


    it 'should work properly', ->
      obj =
        'GOOG' : stock2
      expect(portfolio.stocks).toEqual obj
      savedStocks = JSON.parse(localStorage.getItem('stocks'))
      expect(Object.keys savedStocks).toEqual [stock2.symbol]
        

    it 'should return an array of stocks', ->
      expect(deleteResult).toEqual [stock2]