import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:perial/DataLayer/Models/CurrentUser.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';

final storage = FlutterSecureStorage();
CurrentUser currentUser;

class DataService {
  var baseURL = "http://192.168.0.22:53736/api/";

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
        currentUser = CurrentUser.fromJson(jsonDecode(response.body));
        return response;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  CurrentUser getCurrentUser() {
    return currentUser;
  }

  Future<String> getMembers() async {
    try {
      var response = await http.get(baseURL + 'users', headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
      });
      if ((response.statusCode >= 200 && response.statusCode <= 300)) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getMember(String username) async {
    try {
      var response = await http.get(baseURL + 'user/' + username, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
      });
      if ((response.statusCode >= 200 && response.statusCode <= 300)) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getUsers() async {
    try {
      var response = await http.get(baseURL + 'users', headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
      });
      if ((response.statusCode >= 200 && response.statusCode <= 300)) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> addLike(String username) async {
    try {
      var response = await http.post(baseURL + 'likes/' + username, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getLikes(String command) async {
    try {
      var response = await http.get(baseURL + 'likes?predicate=' + command,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
          });
      if ((response.statusCode >= 200 && response.statusCode <= 300)) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> addDisLike(String username) async {
    try {
      var response = await http.post(baseURL + 'dislikes/' + username,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getDislikes(String command) async {
    try {
      var response = await http.get(baseURL + 'dislikes?predicate=' + command,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ' + currentUser.token
          });
      if ((response.statusCode >= 200 && response.statusCode <= 300)) {
        return response.body;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> get404Error() {
    try {} catch (e) {}
  }
}
