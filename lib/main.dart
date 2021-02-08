import 'dart:convert';

import 'package:app/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:app/bloc/login/login_bloc.dart';
import 'package:app/bloc/profile/profile_bloc.dart';
import 'package:app/bloc/register/register_bloc.dart';
import 'package:app/models/database/user.dart';
import 'package:app/routes.dart';
import 'package:app/ui/auth/login_screen.dart';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/play_now/play_now_screen.dart';
import 'package:app/ui/profiles/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc(),),
        BlocProvider(create: (_) => LoginBloc(),),
        BlocProvider(create: (_) => CompleteProfileBloc(),),
        BlocProvider(create: (_) => ProfileBloc(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: CheckAuth(),
        // home: PlayNowScreen(),
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  bool isFullySet = false;
  @override
  void initState() {
    _checkWhereUserHaveToGo();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(localStorage.getString('user')));
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }

  void _checkWhereUserHaveToGo() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }

    if (localStorage.containsKey('user')) {
      User user = User.fromJson(jsonDecode(localStorage.getString('user')));
      if (user.isFullySet) {
        setState(() {
          isFullySet = true;
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth && !isFullySet) {
      child = CompleteProfileScreen();
    } else if (isAuth && isFullySet) {
      child = MatchesScreen();
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}