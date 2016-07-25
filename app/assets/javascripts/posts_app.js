var app = angular.module('posts', []);

app.controller("PostSearchController", ["$scope", "$http",
  function($scope, $http) {
    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
      $http.get("/posts/list.json",
                { "params": { "q": searchTerm } }
      ).then(function(response) {
          $scope.posts = response.data;
      },function(response) {
          alert("There was a problem: " + response.status);
        }
      );
    }
  }
]);
