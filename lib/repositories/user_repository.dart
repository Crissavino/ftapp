import 'dart:convert';

import 'package:app/models/user.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_location.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Api api = Api();

  // User user;

  Future<bool> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // localStorage.clear();
    final user = jsonDecode(localStorage.getString('user'));
    final data = {"user_id": user['id']};

    final res = await api.postData(data, '/logout');

    final body = json.decode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.remove('user');
      await localStorage.remove('token');
      return true;
    } else {
      return false;
    }
  }

  Future<Map> login(
    String email,
    String password,
  ) async {
    final data = {
      'email': email,
      'password': password,
    };

    final res = await api.authData(data, '/login');

    Map body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString('token', json.encode(body['token']));
      await localStorage.setString('user', json.encode(body['user']));
      body['user'] = User.fromJson(jsonDecode(localStorage.getString('user')));
    }

    return body;
  }

  Future<Map> register(
    String email,
    String password,
    String confirmPassword,
    String fullName,
  ) async {
    final data = {
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'name': fullName,
    };

    final res = await api.authData(data, '/register');

    final Map body = json.decode(res.body);
    if (body.containsKey('success') && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString('token', json.encode(body['token']));
      await localStorage.setString('user', json.encode(body['user']));
      body['user'] = User.fromJson(jsonDecode(localStorage.getString('user')));
    }

    return body;
  }

  Future<bool> isFullySet() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));
    return user.isFullySet;
  }

  Future<User> getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(localStorage.getString('user')));
  }

  Future<bool> existEmail(String email) async {
    final data = {
      'email': email,
    };

    final res = await api.authData(data, '/existEmail');

    final body = json.decode(res.body);

    return body['success'];
  }

  Future<dynamic> completeUserProfile(
    UserPositions userPositions,
    UserLocation userLocationDetails,
    Map<int, UserHoursAvailable> daysAvailable,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": 1, //user.id
      "userPositions": userPositions.toJson(),
      "userLocationDetails": userLocationDetails.toJson(),
      "daysAvailable": UserDaysAvailable().getDataDayAvailable(daysAvailable)
    };

    await Future.delayed(Duration(seconds: 1));
    return {
      "success": true,
    };

    final res = await api.postData(data, '/complete-user-profile');

    final body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      await localStorage.remove('user');
      await localStorage.setString('token', json.encode(body['token']));
      await localStorage.setString('user', json.encode(body['user']));
    }

    return body;
  }
}
