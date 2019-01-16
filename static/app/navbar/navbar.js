(function (angular) {
    var app = angular.module('Aplikacija');
    app.controller('NavbarCtrl', ['loginService', '$scope','$window','$state', function(loginService, $scope,$window,$state) {
        var that = this;
        that.loggedIn = false;
        that.admin = false;

        var onLogin = function() {
            that.loggedIn = true;
            loginService.isAdmin(function(data) {
                that.admin = data;
            },
            function() {
                that.admin = false;
            });
        }

        var onLogout = function() {
            that.loggedIn = false;
            loginService.isAdmin(function(data) {
                that.admin = data;
            },
            function() {
                that.admin = false;
            });
        }

        loginService.addLoginListener($scope, onLogin);
        loginService.addLogoutListener($scope, onLogout);

        that.logout = function() {
            loginService.logout(function(){
                $state.go('home');
                $window.location.reload();
            }, function(){});
        }

        loginService.isLoggedIn(function() {
            that.loggedIn = true;
            
        },
        function() {
            that.loggedIn = false;
        });
        console.log(that.admin);
        
    }]);
})(angular);