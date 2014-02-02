'use strict';

angular.module('testApp')
.directive('stocksWidget', function(){
  var dirOpts;

  dirOpts = {
    restrict: 'E',
    templateUrl: 'views/stocks-widget.html'
  };

  return dirOpts;
});