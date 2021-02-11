import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.userName,
  });

  int id;
  String userName;

  static List<User> parseList(List<dynamic> json) {
    List<User> data = new List<User>();
    for (var item in json) {
      User pos = User.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
      };
}
