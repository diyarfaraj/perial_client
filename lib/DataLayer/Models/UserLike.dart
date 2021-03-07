// To parse this JSON data, do
//
//     final userLike = userLikeFromJson(jsonString);

import 'dart:convert';

UserLike userLikeFromJson(String str) => UserLike.fromJson(json.decode(str));

String userLikeToJson(UserLike data) => json.encode(data.toJson());

class UserLike {
  UserLike({
    this.id,
    this.username,
    this.age,
    this.photoUrl,
    this.city,
  });

  int id;
  String username;
  int age;
  String photoUrl;
  String city;

  static List<UserLike> parseList(List<dynamic> json) {
    List<UserLike> data = new List<UserLike>();
    for (var item in json) {
      UserLike pos = UserLike.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory UserLike.fromJson(Map<String, dynamic> json) => UserLike(
        id: json["id"],
        username: json["username"],
        age: json["age"],
        photoUrl: json["photoUrl"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "age": age,
        "photoUrl": photoUrl,
        "city": city,
      };
}
