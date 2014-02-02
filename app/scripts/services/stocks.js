'use strict';

angular.module('testApp')

.constant('STOCKS_QYL_URL_LOOKUP_URL', 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%3D%22<SYMBOL>%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=')
.constant('STOCKS_YQL_URL_QUOTE_URL', 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%3D%22<SYMBOL>%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=')

.factory('stocks', ['$http', 'STOCKS_QYL_URL_LOOKUP_URL', '$q',
  function($http, STOCKS_QYL_URL_LOOKUP_URL, $q){
  var stocks = {};

  /**
   * @param {String} sym
   */
  stocks.search = function search(sym){
    return $http.get(STOCKS_QYL_URL_LOOKUP_URL.replace('<SYMBOL>', sym))
    .then(function(result){
      var deferred = $q.defer(),
        quote;

      try {
        quote = result.data.query.results.quote;
        deferred.resolve(stocks.dataObjToQuote(quote));
      } catch (e){
        deferred.reject('Could not contact Yahoo finance server. This happens' +
          ' every once in a while, so try again!');
      }

      return deferred.promise;
    });
  };

  /**
   * @param {Object} obj
   */
  stocks.dataObjToQuote = function dataObjToQuote(obj){
    return {
      symbol: obj.symbol,
      price: obj.Ask,
      activity: obj.PercentChange
    };
  };

  return stocks;
}]);