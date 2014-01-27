var searchApp = angular.module('search', ['departments', 'users', 'ngRoute'])

searchApp.config(function($routeProvider, $locationProvider) {
    $routeProvider.
    when('/search', {
        controller: 'SearchResultCtrl',
        templateUrl: 'assets/search/result.html'
    })
})

searchApp.factory('SearchHandler', ['$http',
    function($http) {
        return {
            search: function(conditions) {
                return $http.post('/tickets/search.json', conditions)
            }
        }
    }
])

searchApp.factory('SearchManager', function() {
    var options = {
        aaSorting: [
            [0, "desc"]
        ],
        aoColumns: [{
            "sTitle": "id",
            "bVisible": false
        }, {
            "sTitle": "Title",
            "fnRender": function(oObj) {
                return "<a href='#/tickets/" + oObj.aData[0] + "'>" + oObj.aData[1] + "</a>";
            }
        }, {
            "sTitle": "Customer Name"
        }, {
            "sTitle": "Phone Number"
        }, {
            "sTitle": "In Date"
        }, {
            "sTitle": "Due Date"
        }, {
            "sTitle": "Date Ready"
        }, {
            "sTitle": "Status"
        }],
        aoColumnDefs: [{
            "bSortable": true,
            "aTargets": [0, 1]
        }],
        aaData: []
    };

    return {
        options: options
    }

})

searchApp.controller('SearchResultCtrl', ['$scope', '$filter', 'SearchManager',

    function($scope, $filter, SearchManager) {

        $scope.options = SearchManager.options
        $scope.title = "Search"

        $scope.$watch('options', function(newVal, oldVal) {

            $scope.options = newVal


        })

    }
])

//create ticket controller
searchApp.controller('SearchCtrl', ['$scope', 'Department', 'UserHandler', 'SearchHandler', '$location', '$filter', 'SearchManager',

    function($scope, Department, UserHandler, SearchHandler, $location, $filter, SearchManager) {

        //getting all the departments
        $scope.departments = Department.query()

        UserHandler.list().then(function(d) {
            $scope.users = d.data
        })

        $scope.search = function() {
            result = SearchHandler.search($scope.conditions)

            SearchManager.options.aaData = []
            result.then(function(re) {
                d = re.data

                for (i = 0; i < d.length; i++) {

                    var date_in = $filter('date')(d[i].date_in, 'yyyy-MM-dd')
                    var date_due = $filter('date')(d[i].date_due, 'yyyy-MM-dd')
                    var date_ready = $filter('date')(d[i].date_ready, 'yyyy-MM-dd')

                    SearchManager.options.aaData.push([d[i].id, d[i].title, d[i].first_name + '.' + d[i].last_name, d[i].phone_number, date_in, date_due, date_ready,
                        d[i].status
                    ]);

                }


                $location.path('search')
            })

        }

    }
])