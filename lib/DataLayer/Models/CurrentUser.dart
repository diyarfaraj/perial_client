import 'dart:convert';

import 'package:perial/DataLayer/Models/UserLike.dart';

CurrentUser userFromJson(String str) => CurrentUser.fromJson(json.decode(str));

String userToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  String username;
  String token;
  String password;

  CurrentUser({this.username, this.password, this.token});

  static List<CurrentUser> parseList(List<dynamic> json) {
    List<CurrentUser> data = new List<CurrentUser>();
    for (var item in json) {
      CurrentUser pos = CurrentUser.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
      username: json["username"],
      password: json["password"] ?? "",
      token: json["token"]);

  Map<String, dynamic> toJson() =>
      {"username": username, "password": password, "token": token};
}
