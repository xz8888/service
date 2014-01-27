var departmentModule = angular.module('departments', ['ngResource'])

//department resource
departmentModule.factory('Department', ['$resource', function($resource){
	return $resource('/departments/:departmentId.json')
}]);



