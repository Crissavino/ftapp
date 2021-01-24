class UserLocation {
  final String country;
  final String countryCode;
  final String province;
  final String provinceCode;
  final String city;
  double lat;
  double lng;

  UserLocation({
    this.country,
    this.countryCode,
    this.province,
    this.provinceCode,
    this.city,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toJson() => {
    "country": country,
    "countryCode": countryCode,
    "province": province,
    "provinceCode": provinceCode,
    "city": city,
    "lat": lat,
    "lng": lng,
  };
}
