import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class DataService {
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
}
