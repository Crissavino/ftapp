import 'dart:io';

import 'package:app/models/user.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/ui/chats/chats_screen.dart';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/play_now/play_now_screen.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/slide_bottom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserRepository _userRepository = UserRepository();
  User user;

  // text field state
  String fullName = '';
  String email = '';
  String localeName = Platform.localeName.split('_')[0];
  bool _gkPos = false;
  bool _defPos = false;
  bool _mfPos = false;
  bool _forPos = false;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    this.user = await _userRepository.getUser();

    // if(user != null) {
    //   setState(() {
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SafeArea(
          top: false,
          child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Center(
                child: Container(
                  height: _height,
                  decoration: horizontalGradient,
                  padding: EdgeInsets.only(top: 25.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              height: innerHeight * 0.87,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: screenBorders,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, -2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 50.0),
                                  _buildUserName(),
                                  SizedBox(height: 15.0),
                                  _buildUserReviews(innerWidth),
                                  SizedBox(height: 15.0),
                                  _buildUserPositions(innerWidth),
                                  SizedBox(height: 15.0),
                                  _buildLogOutButton(),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage('assets/profile_cs.jpg'),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBarRounded(),
          ),
        ),
      ],
    );
  }

  _buildUserPositions(innerWidth) {
    return Container(
      width: innerWidth * .95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('Pisiciones'),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  width: innerWidth * .43,
                  height: 60.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  width: innerWidth * .43,
                  height: 60.0,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  width: innerWidth * .43,
                  height: 60.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                  ),
                  width: innerWidth * .43,
                  height: 60.0,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FlatButton(
                onPressed: () {
                  print('Editar posicion');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Editar'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildLogOutButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FlatButton(
          splashColor: Colors.transparent,
          onPressed: _logout,
          child: Text('Cerrar sesion'),
        ),
      ),
    );
  }

  void _logout() async {
    final resLogout = await UserRepository().logout();
    if (resLogout) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      print('Error con el logout');
    }
  }

  void _navigateToSection(index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          SlideBottomRoute(
            page: PlayNowScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          SlideBottomRoute(
            page: MatchesScreen(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          SlideBottomRoute(
            page: ChatsScreen(),
          ),
        );
        break;
      default:
        return;
        break;
    }
  }

  Widget _buildBottomNavigationBarRounded() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      iconSize: 30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.green[400],
      unselectedItemColor: Colors.green[900],
      currentIndex: 3,
      backgroundColor: Colors.white,
      onTap: (index) {
        if (index != 3) {
          _navigateToSection(index);
        }
        print(index);
        // Navigator.pushReplacementNamed(context, 'profile');
      },
      items: [
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Partidos'),
          icon: Icon(Icons.calendar_today_rounded),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Juga ya!'),
          icon: Icon(
            Icons.sports_soccer,
          ),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Chats'),
          icon: Icon(Icons.chat_bubble_outline_rounded),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Text('Perfil'),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  _buildUserReviews(innerWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 2.0,
        ),
        Container(
          width: innerWidth * .3,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Puntualidad',
                  style: kLabelStyleBlack,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          width: innerWidth * .3,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Puntualidad',
                  style: kLabelStyleBlack,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          width: innerWidth * .3,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Puntualidad',
                  style: kLabelStyleBlack,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                    Icon(
                      Icons.star_border,
                      size: 20.0,
                      color: Colors.yellow[700],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 2.0,
        ),
      ],
    );
  }

  _buildUserName() {
    return Text(
      'Cris Savino',
      style:
          TextStyle(color: Colors.black, fontFamily: 'Nunito', fontSize: 30.0),
    );
  }
}
