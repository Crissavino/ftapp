class UserPositions {
  final bool goalKeeper;
  final bool defense;
  final bool midfielder;
  final bool forward;

  UserPositions({this.goalKeeper, this.defense, this.midfielder, this.forward});

  Map<String, bool> toJson() => {
    "goalKeeper": goalKeeper,
    "defense": defense,
    "midfielder": midfielder,
    "forward": forward,
  };
}