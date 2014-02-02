'use strict';

angular.module('testApp')
.factory('portfolio', function(){
  var portfolio = {};

  /**
   * @returns {Array} An array with the stocks, unknown order.
   */
  portfolio.getStocks = function getStocks(){
    if (!this.stocks){
      try {
        this.stocks = localStorage.getItem('stocks');
        this.stocks = JSON.parse(this.stocks);
        if (!this.stocks) {
          this.stocks = {};
        }
      } catch (e){
        this.stocks = {};
      }
    }

    return arrayValues(this.stocks);
  };

  /**
   * @param {Object} stock
   */
  portfolio.saveStock = function saveStock(stock){
    if (!stock){
      throw new Error('tried to save invalid stock');
    }
    this.stocks[stock.symbol] = stock;
    localStorage.setItem('stocks', JSON.stringify(cleanCollection(this.stocks)));

    return arrayValues(this.stocks);
  };


  /**
   * @param {String} symbol
   * @returns {Array} Array with the stocks, unknown order.
   */
  portfolio.deleteStock = function removeStock(symbol){
    delete this.stocks[symbol];
    localStorage.setItem('stocks', JSON.stringify(cleanCollection(this.stocks)));
    return arrayValues(this.stocks);
  };


  /**
   * @param {Object}
   * @returns {Array}
   */
  function arrayValues(obj){
    return Object.keys(obj).map(function(key){
      return obj[key];
    });
  }


  /**
   * @param {Object}
   * @returns {Object}
   */
  function cleanCollection(obj){
    obj = angular.copy(obj);
    Object.keys(obj).forEach(function(key){
      delete obj[key].$$hashKey;
    });

    return obj;
  }

  return portfolio;
});