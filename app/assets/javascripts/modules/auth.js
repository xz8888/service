var auth = angular.module('auth', ['ngCookies'])

auth.factory('Auth', ['$http', '$cookieStore',
    function($http, $cookieStore) {
        //getting the user info
        var _user = {}

        return {

            user: _user,

            requestCurrentUser: function() {
                return $http.get('/current_user.json').then(function(d) {
                    console.log(d)

                })
            },

            set: function(_user) {
                existing_cookie_user = $cookieStore.get('current.user')

                _user = _user || existing_cookie_user;

                $cookieStore.put('current.user', _user)
            },

            //remove
            remove: function() {
                $cookieStore.remove('current.user', _user)
            },

            is_authenticated: function() {

            }

        }

    }
])

auth.run(['Auth',
    function run(Auth) {
        var _user = Auth.requestCurrentUser()
        Auth.set(_user)
    }
])