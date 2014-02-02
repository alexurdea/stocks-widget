'use strict';

angular.module('testApp')
.directive('stocksTable', function(){
  return {
    restrict: 'A',
    templateUrl: 'views/stocks-table.html',
    scope: {
      stocks: '=',
      action: '&',
      icon: '@'
    }
  };
});