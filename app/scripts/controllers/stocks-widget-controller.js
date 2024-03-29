'use strict';

angular.module('testApp')
.constant('STOCK_POLL_INTERVAL', 15000)
.controller('StocksWidgetCtrl', ['$scope', '$interval', 'portfolio', 'stocks', 'STOCK_POLL_INTERVAL',
  function($scope, $interval, portfolio, stocks, STOCK_POLL_INTERVAL){
  $scope.stocks = portfolio.getStocks();
  $scope.mode = $scope.stocks.length > 0 ? 'portfolio' : 'search';


  /**
   * @param {'search'|'portfolio'} mode
   */
  $scope.changeMode = function changeMode(mode){
    $scope.mode = mode;
    $scope.message = null;
  };


  /**
   * @param {String} sym
   */
  $scope.searchSymbol = function(sym){
    stocks.search(sym)
    .then(function success(result){
      $scope.result = result;
      $scope.message = null;
      $scope.searchItem = null;
    }, function reject(reason){
      $scope.message = reason;
      $scope.result = null;
    });
  };


  function updatePortfolio(){
    $scope.stocks.forEach(function(stock){
      stocks.search(stock.symbol)
      .then(function(result){
        $scope.stocks = portfolio.saveStock(result);
      });
    });
  }
  
  $interval(updatePortfolio, STOCK_POLL_INTERVAL);


  /**
   * @param {Object} stock
   */
  $scope.addStock = function addStock(stock){
    // Angular adds this when using obj in collection passed to ng-repeat
    $scope.stocks = portfolio.saveStock(stock);
    $scope.message = stock.symbol + ' added to your portfolio';
    $scope.result = null;
  };


  /**
   * @param {Object} stock
   */
  $scope.removeStock = function removeStock(stock){
    $scope.stocks = portfolio.deleteStock(stock.symbol);
    $scope.message = stock.symbol + ' removed from your portfolio';
  };

}]);