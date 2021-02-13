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

  Future<bool> login(String username, String password) async {
    try {
      var data = {"userName": username, "password": password};
      var response = await http.post(baseURL, body: data);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
