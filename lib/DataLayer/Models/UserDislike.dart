import 'dart:convert';

UserDislike userLikeFromJson(String str) =>
    UserDislike.fromJson(json.decode(str));

String userLikeToJson(UserDislike data) => json.encode(data.toJson());

class UserDislike {
  UserDislike({
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

  static List<UserDislike> parseList(List<dynamic> json) {
    List<UserDislike> data = new List<UserDislike>();
    for (var item in json) {
      UserDislike pos = UserDislike.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory UserDislike.fromJson(Map<String, dynamic> json) => UserDislike(
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
