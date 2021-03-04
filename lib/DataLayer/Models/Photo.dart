import 'dart:convert';

Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
    this.id,
    this.photoUrl,
    this.isMain,
  });

  int id;
  String photoUrl;
  bool isMain;

  static List<Photo> parseList(List<dynamic> json) {
    List<Photo> data = new List<Photo>();
    for (var item in json) {
      Photo pos = Photo.fromJson(item);
      data.add(pos);
    }
    return data;
  }

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["Id"],
        photoUrl: json["photoUrl"],
        isMain: json["isMain"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "photoUrl": photoUrl,
        "isMain": isMain,
      };
}
