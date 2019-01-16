(function (angular) {
    var app = angular.module('Aplikacija');
    app.controller('MoviesListCtrl', ['loginService','$http', '$rootScope','$state','$scope', function(loginService,$http,$rootScope,$state,$scope) {
        var that = this;

        that.movies = []

        that.loggedIn = false;

        that.user = [];

        that.admin = false;

        that.star1 = false;
        that.star2 = false;
        that.star3 = false;
        that.star4 = false;
        that.star5 = false;

        that.order = '';

        that.fetchArticles = function() {
            $http.get('movies').then(
                function(response) {
                    that.movies = response.data;
                    console.log(that.movies)
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }
        
        loginService.isLoggedIn(function() {
            that.loggedIn = true;
        },
        function() {
            that.loggedIn = false;
        });

        loginService.getLoggedIn(function(data) {
            that.user = data;
        },
        function() {
            
        });

        loginService.isAdmin(function(data) {
                that.admin = data;
            },
            function() {
                that.admin = false;
            });

        that.star1Clicked = function(id) {
            console.log("Film broj " + id);
            console.log("star1");

            $http.get("movies/"+1+"/"+id+"/"+that.user['iduser']).then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );

        }
        that.star2Clicked = function(id) {
            console.log("Film broj " + id);
            console.log("star2");

            $http.get("movies/"+2+"/"+id+"/"+that.user['iduser']).then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }
        that.star3Clicked = function(id) {
            console.log("Film broj " + id);
            console.log("star3");

            $http.get("movies/"+3+"/"+id+"/"+that.user['iduser']).then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }
        that.star4Clicked = function(id) {
            console.log("Film broj " + id);
            console.log("star4");

            $http.get("movies/"+4+"/"+id+"/"+that.user['iduser']).then(
                function(response) {
                    that.movies = response.data;
                    console.log(that.movies)
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }
        that.star5Clicked = function(id) {
            console.log("Film broj " + id);
            console.log("star5");

            $http.get("movies/"+5+"/"+id+"/"+that.user['iduser']).then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }
        
        that.rate = function(id) {
            
        }


        that.newOrder = function(order) {
            console.log(order);
            $http.get('movies/' + order).then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }

        that.fetchArticles()
    }]);
})(angular);