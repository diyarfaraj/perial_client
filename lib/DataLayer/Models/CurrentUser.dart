import 'dart:convert';

import 'package:perial/DataLayer/Models/UserLike.dart';

CurrentUser userFromJson(String str) => CurrentUser.fromJson(json.decode(str));

String userToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  String username;
  String token;
  String password;
  int age;
  String city;
  String country;
  String lookingFor;
  String interests;
  String introduction;
  String mainPhoto;

  CurrentUser(
      {this.username,
      this.password,
      this.token,
      this.age,
      this.city,
      this.country,
      this.interests,
      this.introduction,
      this.lookingFor,
      this.mainPhoto});

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
      token: json["token"],
      age: json["age"],
      city: json["city"],
      country: json["country"],
      interests: json["interests"],
      introduction: json["introduction"],
      lookingFor: json["lookingFor"],
      mainPhoto: json["photoUrl"]);

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "token": token,
        "age": age,
        "city": city,
        "country": country,
        "interests": interests,
        "introduction": introduction,
        "lookingFor": lookingFor,
        "mainPhoto": mainPhoto
      };
}
