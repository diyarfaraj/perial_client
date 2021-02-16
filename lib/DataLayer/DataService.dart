import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:perial/DataLayer/Models/User.dart';

class DataService {
  var baseURL = "http://192.168.0.22:53736/api/";

  static Future<String> getUsers() async {
    try {
      var response = await http.get("http://192.168.0.22:53736/api/users");

      if ((response.statusCode >= 200)) {
        return response.body;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<http.Response> login(String username, String password) async {
    try {
      var data = {"userName": username, "password": password};
      var response = await http.post(baseURL + 'account/login',
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json"
          });

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  Future<bool> register(String username, String password) async {
    try {
      var data = {"userName": username, "password": password};
      var response = await http.post(baseURL + 'account/register',
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json"
          });

      if (response.statusCode >= 200) {
        return false;
      }

      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
