import 'dart:convert';

import 'package:app/models/database/user.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayNowRepository {
  Api api = Api();

  Future<dynamic> getUserOffers(
    int range,
      Map<String, bool> gender,
    UserPositions positions,
    Map<int, UserHoursAvailable> daysAvailable,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": user.id,
      "range": range,
      "isMale": gender['men'] ? true : false,
      "isMix": gender['mix'],
      "positions": positions.toJson(),
      "daysAvailable": UserDaysAvailable().getDataDayAvailable(daysAvailable),
    };

    final res = await api.postData(data, '/play-now/get-user-offers');

    final body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      // await localStorage.setString('user', json.encode(body['user']));
    }

    return body;
  }
}
