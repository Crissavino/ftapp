import 'dart:convert';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/play_now/play_now_screen.dart';
import 'package:app/ui/profiles/profile_screen.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/slide_bottom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String name;
  dynamic search = '';

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    Widget _buildSearchTF() {
      final width = MediaQuery.of(context).size.width;

      return Row(
        children: [
          Container(
            height: 30.0,
            width: width * 0.95,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: -3),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: 'Buscar',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (val) {
                setState(() => search = val);
              },
            ),
          ),
        ],
      );
    }

    GestureDetector _buildChatRoomRow(BuildContext context, isUnread) {
      return GestureDetector(
        onTap: () async {
          // Navigator.push(
          //   context,
          //   SlideBottomRoute(
          //     page: ChatRoomScreen(),
          //   ),
          // );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(
                        'https://img2.freepng.es/20180228/grw/kisspng-logo-football-photography-vector-football-5a97847a010f99.3151271415198792900044.jpg'),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Prueba',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          'Ultimo mensaje',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '20:10',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  isUnread
                      ? Container(
                          width: 40.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(''),
                ],
              ),
            ],
          ),
        ),
      );
    }

    _buildChatRoomList() {
      return ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            child: _buildChatRoomRow(
              context,
              true,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                // TODO fijar el chat y siempre mostartlo arriba de todo
                print('otras accociones');
              } else {
                // TODO eliminar el chat
                print('eliminar');
              }
            },
            key: Key(index.toString()),
            // key: Key(this._allMyChatRooms[index].chat.id),
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black26,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(Icons.push_pin, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Fijar chat',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ],
                ),
              ),
            ),
            secondaryBackground: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('Eliminar chat',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        SafeArea(
          top: false,
          child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Center(
                child: Container(
                  decoration: horizontalGradient,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: horizontalGradient,
                              padding: EdgeInsets.only(left: 10.0, top: 43.0),
                              alignment: Alignment.center,
                              child: _buildSearchTF(),
                            ),
                          ),
                          Positioned(
                            top: 80.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, -2),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: screenBorders,
                              ),
                              padding: EdgeInsets.only(
                                  bottom: 20.0, left: 20.0, right: 20.0, top: 2.0),
                              margin: EdgeInsets.only(top: 20.0),
                              width: _width,
                              height: _height,
                              child: _buildChatRoomList(),
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
        )
      ],
    );
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
      case 3:
        Navigator.push(
          context,
          SlideBottomRoute(
            page: ProfileScreen(),
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
      backgroundColor: Colors.white,
      currentIndex: 2,
      onTap: (index) {
        if (index != 2) {
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
}
