class UserHoursAvailable {
  final bool is08Available;
  final bool is810Available;
  final bool is1011Available;
  final bool is1112Available;
  final bool is1213Available;
  final bool is1314Available;
  final bool is1415Available;
  final bool is1516Available;
  final bool is1617Available;
  final bool is1718Available;
  final bool is1819Available;
  final bool is1920Available;
  final bool is2021Available;
  final bool is2122Available;
  final bool is2223Available;
  final bool is2300Available;

  UserHoursAvailable({
    this.is08Available,
    this.is810Available,
    this.is1011Available,
    this.is1112Available,
    this.is1213Available,
    this.is1314Available,
    this.is1415Available,
    this.is1516Available,
    this.is1617Available,
    this.is1718Available,
    this.is1819Available,
    this.is1920Available,
    this.is2021Available,
    this.is2122Available,
    this.is2223Available,
    this.is2300Available,
  });

  Map<String, bool> toJson() => {
  "is08Available": is08Available,
  "is810Available": is810Available,
  "is1011Available": is1011Available,
  "is1112Available": is1112Available,
  "is1213Available": is1213Available,
  "is1314Available": is1314Available,
  "is1415Available": is1415Available,
  "is1516Available": is1516Available,
  "is1617Available": is1617Available,
  "is1718Available": is1718Available,
  "is1819Available": is1819Available,
  "is1920Available": is1920Available,
  "is2021Available": is2021Available,
  "is2122Available": is2122Available,
  "is2223Available": is2223Available,
  "is2300Available": is2300Available,
};
}
