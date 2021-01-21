class UserLocation {
  final String country;
  final String countryCode;
  final String province;
  final String provinceCode;
  final String city;

  UserLocation({
    this.country,
    this.countryCode,
    this.province,
    this.provinceCode,
    this.city,
  });

  Map<String, String> toJson() => {
    "country": country,
    "countryCode": countryCode,
    "province": province,
    "provinceCode": provinceCode,
    "city": city,
  };
}
