// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:app/models/database/days_available.dart';
import 'package:app/models/database/location.dart';
import 'package:app/models/database/position.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isFullySet,
    this.online,
    this.genre,
    this.positions,
    this.location,
    this.daysAvailables,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  bool isFullySet;
  bool online;
  String genre;
  List<Position> positions;
  Location location;
  List<DaysAvailable> daysAvailables;
  DateTime deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      isFullySet: json["isFullySet"] == 1 ? true : false,
      online: json["online"] == 1 ? true : false,
      genre: json["genre"],
      positions: (json["positions"] == null || json["positions"] == []) ? [] : List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      daysAvailables: (json["days_availables"] == null || json["days_availables"] == []) ? [] : List<DaysAvailable>.from(json["days_availables"].map((x) => DaysAvailable.fromJson(x))),
      deletedAt: json["deleted_at"] != null
          ? DateTime.parse(json["deleted_at"])
          : null,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "isFullySet": isFullySet,
        "online": online,
        "genre": genre,
        "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
        "location": location.toJson(),
        "days_availables": List<dynamic>.from(daysAvailables.map((x) => x.toJson())),
        "deleted_at": deletedAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  User copyWith({
    int id,
    String name,
    String email,
    dynamic emailVerifiedAt,
    bool isFullySet,
    bool online,
    dynamic deletedAt,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isFullySet: isFullySet ?? this.isFullySet,
        online: online ?? this.online,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
