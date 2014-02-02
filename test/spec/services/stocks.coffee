describe 'stocks service', ->
  $httpBackend = null
  stocks = null
  STOCKS_QYL_URL_LOOKUP_URL = null
  mockResponse =
      query:
        results:
          quote:
            symbol: 'GOOG'
            Ask: '1180.97'
            PercentChange: '+4.01%'

  beforeEach module 'testApp'

  beforeEach inject ($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    stocks = $injector.get 'stocks'
    STOCKS_QYL_URL_LOOKUP_URL = $injector.get 'STOCKS_QYL_URL_LOOKUP_URL'

  it 'should return a promise and resolve it', ->
    sym = 'GOO'
    lookupUrl = STOCKS_QYL_URL_LOOKUP_URL.replace '<SYMBOL>', sym

    $httpBackend
    .when('GET', lookupUrl)
    .respond mockResponse

    $httpBackend.expectGET lookupUrl

    stocks.search(sym)
    .then (quote) ->
      expect(quote).toEqual stocks.dataObjToQuote(mockResponse.query.results.quote)
    

    $httpBackend.flush()