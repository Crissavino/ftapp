import 'package:app/models/user_hours_available.dart';

class UserDaysAvailable {
  Map<int, UserHoursAvailable> _daysAvailable = {
    0: null,
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
  };

  Map<int, UserHoursAvailable> get daysAvailable => _daysAvailable;

  setDaysAvailable(int dayOfTheWeek, UserHoursAvailable hoursAvailable) {
    _daysAvailable.update(dayOfTheWeek, (value) => hoursAvailable);
  }

  getDataDayAvailable(daysAvailable) {
    final dataDaysAvailable = [];
    daysAvailable.forEach((key, value) {
      dataDaysAvailable.add(value?.toJson());
    });
    return dataDaysAvailable;
  }

  Map<String, dynamic> toJson() => {
    "0": _daysAvailable[0].toJson(),
    "1": _daysAvailable[1].toJson(),
    "2": _daysAvailable[2].toJson(),
    "3": _daysAvailable[3].toJson(),
    "4": _daysAvailable[4].toJson(),
    "5": _daysAvailable[5].toJson(),
    "6": _daysAvailable[6].toJson(),
  };

}