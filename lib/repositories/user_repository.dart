import 'dart:convert';

import 'package:app/models/database/days_available.dart';
import 'package:app/models/database/location.dart';
import 'package:app/models/database/position.dart';
import 'package:app/models/database/user.dart';
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

    if (body['success'] == true) {
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
    bool isMale
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": user.id,
      "userPositions": userPositions.toJson(),
      "userLocationDetails": userLocationDetails.toJson(),
      "daysAvailable": UserDaysAvailable().getDataDayAvailable(daysAvailable),
      "isMale": isMale
    };

    final res = await api.postData(data, '/complete-user-profile');

    final body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      await localStorage.setString('user', json.encode(body['user']));
      await localStorage.setString('userPositions', json.encode(body['user']['positions']));
      await localStorage.setString('userDaysAvailables', json.encode(body['user']['days_availables']));
      await localStorage.setString('userLocation', json.encode(body['user']['location']));
    }

    return body;
  }

  Future<List<Position>> getUserPositions() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<Position> userPositions = [];
    jsonDecode(localStorage.getString('userPositions')).forEach((element) {
      userPositions.add(Position.fromJson(element));
    });

    return userPositions;
  }

  Future<List<DaysAvailable>> getUserDaysAvailables() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<DaysAvailable> userDaysAvailable = [];
    jsonDecode(localStorage.getString('userDaysAvailables')).forEach((element) {
      userDaysAvailable.add(DaysAvailable.fromJson(element));
    });
    return userDaysAvailable;
  }

  Future<Location> getUserLocation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return Location.fromJson(jsonDecode(localStorage.getString('userLocation')));
  }

  Future<dynamic> editUserPositions(UserPositions userPositions) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": user.id,
      "userPositions": userPositions.toJson(),
    };

    final res = await api.postData(data, '/edit-user-positions');

    final body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      await localStorage.setString('user', json.encode(body['user']));
      await localStorage.setString('userPositions', json.encode(body['user']['positions']));
    }

    return body;
  }

  Future<dynamic> editUserDaysAvailable(Map<int, UserHoursAvailable> daysAvailable) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));

    final data = {
      "user_id": user.id,
      "daysAvailable": UserDaysAvailable().getDataDayAvailable(daysAvailable),
    };

    final res = await api.postData(data, '/edit-user-days-available');

    final body = json.decode(res.body);

    if (body.containsKey('success') && body['success'] == true) {
      await localStorage.setString('user', json.encode(body['user']));
      await localStorage.setString('userDaysAvailables', json.encode(body['user']['days_availables']));
    }

    return body;
  }


}
