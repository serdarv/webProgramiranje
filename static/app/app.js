(function (angular) {
    //Kreiranje angular aplikacije.
    //Ova aplikacija nema dodatnih zavisnosti.
    var app = angular.module('Aplikacija', ['ui.router', 'ngFileUpload', 'loginService']);

    app.config(['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise('/');
        //Korensko apstraktno stanje, kontejner za ostala stanja.
        $stateProvider.state('app', {
            abstract: true,
            views: {
                //Navbar se prikazuje na svakoj stranici.
                navbar: {
                    templateUrl: 'app/navbar/navbar.tpl.html',
                    controller: 'NavbarCtrl',
                    controllerAs: 'nb'
                },
                //Ostale stranice ce se prikazivati u ovom view-u.
                '': {
                    //Potomak korenskog view-a, u njemu se prikazuju ostali template-i.
                    template: '<ui-view name=""></ui-view>'
                }
            }
        })
        //Moglo je i app.home ali bi moralo da se menja
        //referenciranje pomocu ui-sref.
        $stateProvider.state('home', {
            url: '/',
            parent: 'app', //Da se ne bi menjalo referenciranje stanja
            views: {       //u ui-sref ovde se navodi parent.
                '': {
                    templateUrl: 'app/movies/movies.tpl.html',
                    controller: 'MoviesListCtrl',
                    controllerAs: 'ml'
                }
            }
        }).state('admin', {
            parent: 'app',
            url: '/admin-panel',
            views: {
                '': {
                    templateUrl: 'app/admin-panel/admin-panel.tpl.html',
                    controller: 'AdminCtrl',
                    controllerAs: 'ac'
                }
            }
        }).state('login', {
            parent: 'app',
            url: '/login',
            views: {
                '': {
                    templateUrl: 'app/login/login.tpl.html',
                    controller: 'LoginCtrl',
                    controllerAs: 'lc'
                }
            }
        }).state('welcome', {
            parent: 'app',
            url: '/welcome',
            views: {
                '': {
                    templateUrl: 'app/welcome_page.html'
                }
            }
        }).state('add-new', {
            parent: 'app',
            url: '/add-new-movie',
            views: {
                '': {
                    templateUrl: 'app/add-new-movie/add-new-movie.tpl.html',
                    controller: 'AddNewMovieCtrl',
                    controllerAs: 'an'
                }
            }
        });
    }]);
})(angular);