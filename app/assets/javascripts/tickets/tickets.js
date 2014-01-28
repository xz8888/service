var ticketApp = angular.module('tickets', ['departments', 'users', 'ngRoute'])

ticketApp.config(function($routeProvider, $locationProvider) {
    $routeProvider.
    when('/tickets/new', {
        templateUrl: 'assets/tickets/new.html',
        controller: 'TicketNewCtrl'
    }).
    when('/tickets', {
        templateUrl: 'assets/tickets/list.html',
        controller: 'TicketListCtrl'
    }).
    when('/tickets/:ticketId', {
        templateUrl: 'assets/tickets/view.html',
        controller: 'TicketViewCtrl'
    })
})


//create the http service
ticketApp.factory('TicketHandler', ['$http',
    function($http) {
        return {
            create: function(ticket) {
                return $http.post('/tickets.json', ticket)
            },

            list: function() {
                var promise = $http.get('/tickets.json').then(function(response) {
                    return response.data
                })

                return promise;
            },
            view: function(id) {
                var promise = $http.get('/tickets/' + id + '.json').then(function(response) {
                    return response.data
                })

                return promise;
            },
            updateTicketStatus: function(id, newStatus) {
                var data = {
                    'id': id,
                    'status': newStatus
                }

                var promise = $http.post('/tickets/status.json', data).then(function(response) {
                    return response.data
                })

                return promise;
            },
            updateTicketTime: function(id, type, new_date) {
                var data = {
                    'id': id,
                    'type': type,
                    'new_date': new_date
                }

                var promise = $http.post('/tickets/updatedate.json', data).then(function(response) {
                    return response.data
                })
            },

            addComment: function(comment) {
                return $http.post('/tickets/comment.json', comment)
            }

        }
    }
])

//create ticket controller
ticketApp.controller('TicketNewCtrl', ['$scope', 'TicketHandler', 'Department', 'UserHandler', '$location',

    function($scope, TicketHandler, Department, UserHandler, $location) {
        $scope.title = "New Ticket";
        $scope.description_template = "description.html"
        //getting all the departments
        $scope.departments = Department.query()
        $scope.ticket = {}
        $scope.ticket.products = new Array()

        UserHandler.list().then(function(d) {
            $scope.users = d.data
        })

        //handle the ticket creation process
        $scope.createTicket = function() {
            var ticket = $scope.ticket;

            if (ticket.department_id)
                ticket.department_id = ticket.department_id.id

            ticket.status = "new"
            var theData = TicketHandler.create(ticket)
            theData.then(function(d) {
                var ticket = d.data;
                var ticketId = ticket.id;

                $location.path('/tickets/' + ticketId).hash('ticket')

            })
            //$location.path('/tickets')
        }

        $scope.addProduct = function() {
            if ($scope.product) {
                $scope.ticket.products.push(angular.copy($scope.product))
                $scope.product = {}
            }
        }
    }
])

//list ticket controller
ticketApp.controller('TicketListCtrl', ['$scope', 'TicketHandler', '$filter',

    function($scope, TicketHandler, $filter) {
        console.log('are you there111')
        $scope.title = "Tickets"
        $scope.options = {
            aaSorting: [
                [0, "desc"]
            ],
            aoColumns: [{
                "sTitle": "id",
                "bVisible": false,

            }, {
                "sTitle": "Title",
                "sWidth": "20%",
                "fnRender": function(oObj) {
                    return "<a href='#/tickets/" + oObj.aData[0] + "'>" + oObj.aData[1] + "</a>";
                }
            }, {
                "sTitle": "Customer Name",
                "sWidth": "15%"
            }, {
                "sTitle": "Phone Number",
                "sWidth": "10%"
            }, {
                "sTitle": "In Date",
                "sWidth": "10%"
            }, {
                "sTitle": "Due Date",
                "sWidth": "10%"
            }, {
                "sTitle": "Date Ready",
                "sWidth": "10%"
            }, {
                "sTitle": "Status",
                "sWidth": "6%"
            }],
            aoColumnDefs: [{
                "bSortable": true,
                "aTargets": [0, 1]
            }],
            aaData: []
        };
        //list all the tickets
        TicketHandler.list().then(function(d) {

            for (i = 0; i < d.length; i++) {

                var date_in = $filter('date')(d[i].date_in, 'yyyy-MM-dd')
                var date_due = $filter('date')(d[i].date_due, 'yyyy-MM-dd')
                var date_ready = $filter('date')(d[i].date_ready, 'yyyy-MM-dd')

                $scope.options.aaData.push([d[i].id, d[i].title, d[i].first_name + '.' + d[i].last_name, d[i].phone_number, date_in, date_due, date_ready,
                    d[i].status
                ]);
            }

        })
    }
])

//establish the ticket view
ticketApp.controller('TicketViewCtrl', ['$scope', '$routeParams', 'TicketHandler', '$location', '$anchorScroll',

    function($scope, $routeParams, TicketHandler, $location, $anchorScroll) {

        //set to 
        $location.hash('ticket')

        $anchorScroll();
        //add ticket handling for view ticket
        var ticketId = $routeParams.ticketId;
        TicketHandler.view(ticketId).then(function(d) {
            $scope.title = d.title
            $scope.ticket = d
        })

        $scope.updateStatus = function() {
            //create the update dialog
            TicketHandler.updateTicketStatus(ticketId, $scope.ticket.status)
        }

        $scope.updateDateDue = function() {
            TicketHandler.updateTicketTime(ticketId, 'date_due', $scope.ticket.date_due)
        }

        $scope.updateDateReady = function() {
            TicketHandler.updateTicketTime(ticketId, 'date_ready', $scope.ticket.date_ready)
        }

        $scope.updateDateOut = function() {
            TicketHandler.updateTicketTime(ticketId, 'date_out', $scope.ticket.date_out)
        }

        $scope.addComment = function() {
            //adding the comment 
            var newComment = $scope.comment
            if (newComment.private === undefined)
                newComment.is_private = 0
            else
                newComment.is_private = newComment.private

                newComment.ticket_id = ticketId
            TicketHandler.addComment(newComment).then(function(d) {
                $scope.ticket = d.data
            });

        }
    }
])