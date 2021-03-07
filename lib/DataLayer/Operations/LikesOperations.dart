import 'dart:convert';
import 'package:perial/DataLayer/DataService.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';

class LikesOperations {
  Future addLike(String username) async {
    try {
      await DataService().addLike(username);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UserLike>> getLikes(String command) async {
    try {
      String os = await DataService().getLikes(command);
      if ([null, ""].contains(os)) return new List<UserLike>();
      List<UserLike> o = UserLike.parseList(json.decode(os));
      return o;
    } catch (ex) {
      print('MemeberOperations.getMembers() Ex: ' + ex.toString());
    }
    return new List<UserLike>();
  }
}
