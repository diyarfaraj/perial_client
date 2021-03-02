import 'dart:convert';

import 'package:perial/DataLayer/Models/Photo.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String userName;
  String photoUrl;
  int age;
  String email;
  DateTime createdAt;
  DateTime lastActive;
  String gender;
  String introduction;
  String animalType;
  String lookingFor;
  String interests;
  String city;
  String country;
  List<Photo> photos;

  User({
    this.id,
    this.userName,
    this.photoUrl,
    this.age,
    this.email,
    this.createdAt,
    this.lastActive,
    this.gender,
    this.introduction,
    this.animalType,
    this.lookingFor,
    this.interests,
    this.city,
    this.country,
    this.photos,
  });

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
        "Password": password,
      };
}
