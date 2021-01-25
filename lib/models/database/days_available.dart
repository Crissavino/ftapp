class DaysAvailable {
  DaysAvailable({
    this.id,
    this.dayOfTheWeek,
    this.available,
    this.userId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int dayOfTheWeek;
  String available;
  int userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory DaysAvailable.fromJson(Map<String, dynamic> json) => DaysAvailable(
    id: json["id"],
    dayOfTheWeek: json["dayOfTheWeek"],
    available: json["available"] == 'null' ? null : json["available"],
    userId: json["user_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayOfTheWeek": dayOfTheWeek,
    "available": available,
    "user_id": userId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}