import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String userName;
  String password;

  User({this.id, this.userName, this.password});

  static List<User> parseList(List<dynamic> json) {
    List<User> data = new List<User>();
    for (var item in json) {
      User pos = User.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"], userName: json["userName"], password: json["password"]);

  Map<String, dynamic> toJson() =>
      {"Id": id, "UserName": userName, "Password": password};
}
