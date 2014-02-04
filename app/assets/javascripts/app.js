/* main file of heys application */

//load the necessory modules
angular.module('app', ['tickets', 'auth', 'search'])

angular.module('app').config(["$httpProvider",
    function(provider) {
        provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
]);

//create directives
angular.module('app').directive('onButton', function() {
    return {
        restrict: 'A',
        require: 'ngModel',
        template: '<input type="checkbox" class="toggle" />',
        link: function(scope, element, attr, ctrl) {

            element.bootstrapSwitch();
            element.on('switch-change', function(e, data) {
                scope.$apply(function() {
                    console.log('are you there')
                    ctrl.$setViewValue(data.value);
                })

            })
        }
    }
})

angular.module('app').directive('datePicker', function() {
    return {
        restrict: 'A',
        require: 'ngModel',
        template: '<input class="form-control datepicker" type="text" />',
        link: function(scope, element, attr, ctrl) {

            theElement = element.find('input');

            var picker = theElement.pickadate({
                format: 'yyyy-mm-dd',
                formatSubmit: 'yyyy-mm-dd',
                onSet: function(event) {
                    scope.$apply(function() {
                        ctrl.$setViewValue(picker.val())
                    })
                }
            });

        }
    }
})

//disable click event
angular.module('app').directive('a', function() {
    return {
        restrict: 'E',
        link: function(scope, elem, attrs) {
            if (attrs.ngClick || attrs.href === '' || attrs.href === '#') {
                elem.on('click', function(e) {
                    e.preventDefault();
                    if (attrs.ngClick) {
                        scope.$eval(attrs.ngClick);
                    }
                });
            }
        }
    };
});

//monitor repeat event
angular.module('app').directive('serviceTable', function() {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {

            var dataTable = element.dataTable(scope.options)

            console.log(scope.options)
            scope.$watch('options.aaData', handleModelUpdates, true);

            function handleModelUpdates(newData) {

                var data = newData || null;
                if (data) {
                    dataTable.fnClearTable();
                    dataTable.fnAddData(data);
                }
            }

        }

    }
})