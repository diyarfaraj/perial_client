import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:perial/DataLayer/Models/User.dart';

class DataService {
  var baseURL = "http://192.168.0.22:53736/api/";

  Future<String> getUsers() async {
    try {
      var response = await http.get(baseURL + 'users', headers: {
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJob3VzZSIsIm5iZiI6MTYxNDYzNTgyNSwiZXhwIjoxNjE1MjQwNjI1LCJpYXQiOjE2MTQ2MzU4MjV9.4m7SU2Ss_UUeLkI-FK7YOd-Eq9CgQiGPPwzVrvdK23MUUbsloauK2hwsGl5YACSKUyaGJz6RxCfOJ0fFuKcyhw'
      });

      if ((response.statusCode >= 200)) {
        return response.body;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
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
      print(response);
      if (response.statusCode >= 300) {
        return false;
      }
      return true;
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

  Future<void> get404Error() {
    try {} catch (e) {}
  }
}
