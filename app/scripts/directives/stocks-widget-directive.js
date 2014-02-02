'use strict';

angular.module('testApp')
.directive('stocksWidget', function(){
  var dirOpts;

  dirOpts = {
    restrict: 'E',
    templateUrl: 'views/stocks-widget.html',
    link: function(){
      console.log('linked stocks-widget!');
    }
  };

  return dirOpts;
});