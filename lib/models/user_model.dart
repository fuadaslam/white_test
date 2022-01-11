
import 'dart:convert';

import 'package:flutter/cupertino.dart';
List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class User {
  User(
  {this.id,
  @required this.name,
  @required this.email,
  @required this.avatarUrl});
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["userId"],
    name: json["name"],
    email: json["email"],
    avatarUrl: json["profile_image"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "profile_image": avatarUrl,
  };
}