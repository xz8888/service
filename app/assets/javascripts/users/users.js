var userApp = angular.module('users', [])

//defining user services
userApp.factory('UserHandler', ['$http',
    function($http) {
        return {
            list: function() {
                var promise = $http.get('/page/users.json')
                return promise
            }
        }
    }
])