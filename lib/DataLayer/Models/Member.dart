import 'dart:convert';

import 'package:perial/DataLayer/Models/Photo.dart';
import 'package:perial/DataLayer/Models/UserLike.dart';

Member userFromJson(String str) => Member.fromJson(json.decode(str));

String userToJson(Member data) => json.encode(data.toJson());

class Member {
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

  Member({
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

  static List<Member> parseList(List<dynamic> json) {
    List<Member> data = new List<Member>();
    for (var item in json) {
      Member pos = Member.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  //https://dev.to/carminezacc/user-authentication-jwt-authorization-with-flutter-and-node-176l
  //todo:

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        userName: json["username"],
        photoUrl: json["photoUrl"],
        age: json["age"],
        email: json["email"],
        createdAt: DateTime.parse(json["created"]),
        lastActive: DateTime.parse(json["lastActive"]),
        gender: json["gender"],
        introduction: json["introduction"],
        animalType: json["animalType"],
        lookingFor: json["lookingFor"],
        interests: json["interests"],
        city: json["city"],
        country: json["country"],
        photos: Photo.parseList(json["photos"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "photoUrl": photoUrl,
        "age": age,
        "email": email,
        "createdAt": createdAt,
        "lastActive": lastActive,
        "gender": gender,
        "introduction": introduction,
        "animalType": animalType,
        "lookingFor": lookingFor,
        "interests": interests,
        "city": city,
        "country": country,
        "photos": photos
      };
}
