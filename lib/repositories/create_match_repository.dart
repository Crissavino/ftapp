import 'dart:convert';

import 'package:app/models/database/user.dart';
import 'package:app/models/user_location.dart';
import 'package:app/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateMatchRepository {
  Api api = Api();

  Future<dynamic> createMatch(
    Map<String, bool> gender,
    String whenPlay,
    Map<String, bool> matchType,
    Map<String, int> whatPositions,
    UserLocation matchLocation,
    int cost,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": user.id,
      "gender": gender,
      "whenPlay": whenPlay,
      "matchType": matchType,
      "whatPositions": whatPositions,
      "matchLocation": matchLocation,
      "cost": cost,
    };

    final res = await api.postData(data, '/matches/create');

    final body = json.decode(res.body);

    print(body);

    if (body.containsKey('success') && body['success'] == true) {
      // await localStorage.setString('user', json.encode(body['user']));
    }

    return body;
  }
}
