traineesTango.controller('backersController', ['$scope','$http', function($scope, $http){
  $scope.message = "";

$scope.validate = function(){
  pledge = $("b[data-amount]");
  pledge = parseInt(pledge.html());
  amount = $("input[name='backer[amount]']");
  amount = parseInt(amount.val());
  if (pledge > amount) {
    $("#aviable_message").html("no se puede wey!!!");
    $("input[name='backer[pledge_id]']").val([]);
  }
 };

  

 

}]);

