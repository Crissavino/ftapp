class Location {
  Location({
    this.id,
    this.userId,
    this.country,
    this.countryCode,
    this.province,
    this.provinceCode,
    this.city,
    this.lat,
    this.lng,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String userId;
  String country;
  String countryCode;
  String province;
  String provinceCode;
  String city;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic lat;
  dynamic lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    userId: json["user_id"],
    country: json["country"],
    countryCode: json["countryCode"],
    province: json["province"],
    provinceCode: json["provinceCode"],
    city: json["city"],
    lat: json["lat"],
    lng: json["lng"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "country": country,
    "countryCode": countryCode,
    "province": province,
    "provinceCode": provinceCode,
    "city": city,
    "lat": lat,
    "lng": lng,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}