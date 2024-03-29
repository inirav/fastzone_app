import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fastzone/services/connection.dart';
import 'package:fastzone/models/models.dart';


class ApiClient {

  static Future addCustomer(String fullName, String organization,
     String email, String phone, String type, String address, String locality, 
     String city, String pincode) async {
    try {
        var response = await http.post(Uri.parse(Connection.addCustomer), body: {
          'full_name': fullName,
          'organization': organization,
          'email': email,
          'phone': phone,
          'type': type,
          'address': address,
          'locality': locality,
          'city': city,
          'pincode': pincode,
        });
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          debugPrint('register customer $result');
          return result;
        }  
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  static Future editCustomer(int customerId, String fullName, String organization,
     String email, String phone, String type, String address, String locality, 
     String city, String pincode) async {
    try {
        var response = await http.post(Uri.parse(Connection.editCustomer), body: {
          'customer_id': '$customerId',
          'full_name': fullName,
          'organization': organization,
          'email': email,
          'phone': phone,
          'type': type,
          'address': address,
          'locality': locality,
          'city': city,
          'pincode': pincode,
        });
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          debugPrint('result is $result');
          return result;
        }  
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  static Future checkCustomer(String phone) async {
    try {
      var response = await http.post(Uri.parse(Connection.checkCustomer), body: {
        'phone': phone
      });
      if (response.statusCode >= 200 || response.statusCode <= 299) {
        var result = json.decode(response.body);
        debugPrint('api result $result');
        return result;
      }  
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<Category>> getCategories() async {
    try {
        var response = await http.post(Uri.parse(Connection.categories));
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          final status = result['status'];
          if (status == true) {
            List<Category> _categories = [];
            _categories = (result['data'] as List).map((e) => Category.fromJson(e)).toList();
            return _categories;
          }
        }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future<List<Service>> getServices(int categoryId) async {
    try {
        var response = await http.post(Uri.parse(Connection.services), body: {
          'category_id': categoryId.toString()
        });
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          final status = result['status'];
          if (status == true) {
            List<Service> _services = [];
            _services = (result['data'] as List).map((e) => Service.fromJson(e)).toList();
            return _services;
          }
        }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  static Future raiseIssue(String title, String desc, int serviceId, int customerId, List<File> files) async {
    try {
        var request = http.MultipartRequest("POST", Uri.parse(Connection.addIssue))
        ..fields['title'] = title
        ..fields['desc'] = desc
        ..fields['service_id'] = '$serviceId'
        ..fields['customer_id'] = '$customerId';

      for (File file in files) {
        String? fileName = file.path.split("/").last;
        request.files.add(await http.MultipartFile.fromPath(
          'files',
          file.path,
          filename: fileName,
        ));
      }
      var response = await request.send();
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          final responseData = await http.Response.fromStream(response);
          debugPrint('response ${responseData.body}');
          var result = jsonDecode(responseData.body);
          return result;
        } else {
          final responseData = await http.Response.fromStream(response);
          var result = jsonDecode(responseData.body);
          debugPrint(result);
          return 'failed';
      }  
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  static Future getIssue(int customerId) async {
    try {
        var response = await http.post(Uri.parse(Connection.allIssues), body: {
          'customer_id': '$customerId',
        });
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          final status = result['status'];
          if (status == true) {
            List<Issue> _services = [];
            _services = (result['data'] as List).map((e) => Issue.fromJson(e)).toList();
            return _services;
          }
        }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }


  static Future deleteIssue(int issueId) async {
    try {
        var response = await http.post(Uri.parse(Connection.deleteIssue), body: {
          'id': '$issueId'
        });
        if (response.statusCode >= 200 || response.statusCode <= 299) {
          var result = json.decode(response.body);
          return result;
        }  
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


}