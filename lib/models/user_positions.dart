class UserPositions {
  bool goalKeeper;
  bool defense;
  bool midfielder;
  bool forward;

  UserPositions({this.goalKeeper, this.defense, this.midfielder, this.forward});

  Map<String, bool> toJson() => {
    "goalKeeper": goalKeeper,
    "defense": defense,
    "midfielder": midfielder,
    "forward": forward,
  };
}