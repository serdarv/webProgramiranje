(function (angular) {
    var app = angular.module('Aplikacija').directive("fileread", [function () {
            return {
                scope: {
                    fileread: "="
                },
                link: function (scope, element, attributes) {
                    element.bind("change", function (changeEvent) {
                        var reader = new FileReader();
                        reader.onload = function (loadEvent) {
                            scope.$apply(function () {
                                scope.fileread = loadEvent.target.result;
                            });
                        }
                        reader.readAsDataURL(changeEvent.target.files[0]);
                    });
                }
            }
        }]);



    app.controller('AddNewMovieCtrl', ['loginService','$http', '$rootScope','$state','$scope','$timeout', function(loginService,$http,$rootScope,$state,$scope,$timeout) {
        var that = this;


        that.showError = false;

        that.searchterm='';

        that.languages = [];

        that.genres = [];

        that.newMovie = {
            'name':'',
            'imbd_id':'',
            'release_date':'',
            'runtime':'',
            'overview':'',
            'movie_image':'',
            'vote_count':'0',
            'vote_average':'0',
            'genre_idgenre':'',
            'language_idlanguage':''
        }

        that.searchMovies = [];

        that.searchMovie = {
            'name':'',
            'imbd_id':'',
            'release_date':'',
            'runtime':'',
            'overview':'',
            'movie_image':'',
            'vote_count':'0',
            'vote_average':'0',
            'genre_idgenre':'',
            'language_idlanguage':''
        }

        that.addNew = function() {
            that.newMovie['release_date'] = new Date(that.newMovie['release_date']);
            console.log(that.newMovie);
            if(that.newMovie['name']!='' && that.newMovie['imbd_id']!='' && that.newMovie['release_date']!='' && that.newMovie['runtime']!='' && that.newMovie['overview']!='')
            {
                $http.post('movies/newMovie',that.newMovie).then(
                function(response) {
                    that.showError = false;
                    $state.go("admin");
                },
                function(reason) {
                    console.log(reason);
                }
                );
            } else {
                that.showError = true;
            }
            
        }

        that.searchChange = function() {
            that.searchMovies = [];
            if(that.searchterm.length>=3)
            {
                $http.get('https://api.themoviedb.org/3/search/movie?api_key=227a322e90c06f7d1e6eab1ecb7eeb54&query='+that.searchterm,that.newMovie).then(
                function(response) {
                    for (var i = response.data.results.length - 1; i >= 0; i--) {
                        that.searchMovie = response.data.results[i];
                        console.log(response.data.results[i]);
                        console.log(that.searchMovie['runtime']);
                        console.log((that.searchMovie['runtime'] == '' || that.searchMovie['runtime'] == null));
                        that.searchMovie['movie_image'] = "http://image.tmdb.org/t/p/w185/"+that.searchMovie['poster_path'];
                        that.searchMovie['name'] = that.searchMovie['title'];
                        that.searchMovie['imbd_id'] = (that.searchMovie['imbd_id'] == '' || that.searchMovie['imbd_id'] == null) ? '1':that.searchMovie['imbd_id'];
                        that.searchMovie['runtime'] = (that.searchMovie['runtime'] == '' || that.searchMovie['runtime'] == null) ? '1':that.searchMovie['runtime'];
                        that.searchMovie['genre_idgenre'] = 1;
                        that.searchMovie['language_idlanguage'] = 1;
                        that.searchMovies.push(that.searchMovie);
                        
                    }

                    // console.log(that.searchMovies);
                },
                function(reason) {
                    console.log(reason);
                }
            );
            }
            
        }

        that.addNewMovie = function(id) {
            $http.post('movies/newMovie',that.searchMovies[id]).then(
                function(response) {
                    that.showError = false;
                    $state.go("admin");
                },
                function(reason) {
                    console.log(reason);
                }
            );
        }

        $http.get('movies/genres').then(
                function(response) {
                    that.genres = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );

        $http.get('movies/languages').then(
                function(response) {
                    that.languages = response.data;
                },
                function(reason) {
                    console.log(reason);
                }
            );

    }]);
})(angular);