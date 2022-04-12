
class Connection {

  static String url = 'http://192.168.1.101:8000'; 

  static String categories = url + '/api/categories';
  static String services = url + '/api/services';
  static String allIssues = url + '/api/issues';
  static String addIssue = url + '/api/issue/add';
  static String deleteIssue = url + '/api/issue/delete';
  static String checkCustomer = url + '/users/api/customer/check';
  static String addCustomer = url + '/users/api/customer/add';

}