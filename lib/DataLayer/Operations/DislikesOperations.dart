import 'dart:convert';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/UserDislike.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';

class DislikesOperations {
  Future addDislike(String username) async {
    try {
      await DataService().addDisLike(username);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UserDislike>> getDislikes(String command) async {
    try {
      String os = await DataService().getDislikes(command);
      if ([null, ""].contains(os)) return new List<UserDislike>();
      List<UserDislike> o = UserDislike.parseList(json.decode(os));
      return o;
    } catch (ex) {
      print('MemeberOperations.getDislikes() Ex: ' + ex.toString());
    }
    return new List<UserDislike>();
  }
}
