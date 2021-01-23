class Position {
  Position({
    this.id,
    this.sport,
    this.position,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String sport;
  String position;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    id: json["id"],
    sport: json["sport"],
    position: json["position"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sport": sport,
    "position": position,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}