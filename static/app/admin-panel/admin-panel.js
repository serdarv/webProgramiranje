(function (angular) {
    var app = angular.module('Aplikacija');
    app.controller('AdminCtrl', ['loginService','$http', '$rootScope','$state','$scope','$timeout', function(loginService,$http,$rootScope,$state,$scope,$timeout) {
        var that = this;

        that.movies = []
        that.movie;
        that.editing = false;

        that.successfullyEdited= false;
        that.unsuccessfullyEdited= false;

        that.editMovie = {
            'idmovie':'',
            'name':'',
            'imbd_id':'',
            'release_date': '',
            'runtime':'',
            'overview':'',
        }

        that.fetchArticles = function() {
            $http.get('movies').then(
                function(response) {
                    that.movies = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }

        that.editForm = function(id) {
            that.editing = true;
            console.log(that.movies.length);
             for (var i = 0; i < that.movies.length; i++) {
                console.log(that.movies[i]['idmovie']==id)
                 if (that.movies[i]['idmovie']==id) {
                    that.movie = that.movies[i];
                    that.movies = [];
                    that.movie['release_date'] = new Date(that.movie['release_date']);
                    that.movies.push(that.movie);
                    that.editMovie = that.movie;
                 }
             }

             console.log(that.movies);
        }

        that.makeEdit = function() {
            console.log(that.movie)
            $http.post('movies/post',that.movie).then(
                function(response) {
                    if (response.data=="Updated") {
                        that.fetchArticles();
                        that.editing = false;
                        that.successfullyEdited = true;
                        $timeout(function () {
                            that.successfullyEdited = false;
                        }, 5000);
                    } else {
                        that.unsuccessfullyEdited = true;
                        $timeout(function () {
                            that.unsuccessfullyEdited = false;
                        }, 5000);
                    }
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }

        that.delete = function (id) {
            console.log(id);
            $http.delete('movies/delete/'+id).then(
                function(response) {
                    that.fetchArticles();
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }

        that.fetchArticles()

    }]);
})(angular);