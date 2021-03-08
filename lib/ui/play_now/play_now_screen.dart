import 'package:app/models/database/user.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/repositories/play_now_repository.dart';
import 'package:app/ui/chats/chats_screen.dart';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/profiles/profile_screen.dart';
import 'package:app/ui/profiles/public_profile_screen.dart';
import 'package:app/ui/widgets/create_play_now_post.dart';
import 'package:app/ui/widgets/play_now_filter.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayNowScreen extends StatefulWidget {
  @override
  _PlayNowScreenState createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen> {
  dynamic search = '';
  PlayNowRepository _playNowRepository = PlayNowRepository();
  UserPositions _searchedPositions;
  UserDaysAvailable _searchedUserDaysAvailable = UserDaysAvailable();
  Map<int, UserHoursAvailable> daysAvailable;
  bool isMale;
  Map<String, bool> _searchedGender = {
    'men': true,
    'women': false,
    'mix': false,
  };
  Map<String, double> _searchedRange = {
    'distance': 20.0
  };
  // double _searchedRange = 20.0;

  @override
  void initState() {
    // TODO: implement initState

    this._searchedPositions = UserPositions(
      goalKeeper: true,
      defense: true,
      midfielder: true,
      forward: true,
    );

    UserHoursAvailable emptyUserHoursAvailable = UserHoursAvailable(
      is08Available: true,
      is810Available: true,
      is1011Available: true,
      is1112Available: true,
      is1213Available: true,
      is1314Available: true,
      is1415Available: true,
      is1516Available: true,
      is1617Available: true,
      is1718Available: true,
      is1819Available: true,
      is1920Available: true,
      is2021Available: true,
      is2122Available: true,
      is2223Available: true,
      is2300Available: true,
    );
    this.daysAvailable = {
      0: emptyUserHoursAvailable,
      1: emptyUserHoursAvailable,
      2: emptyUserHoursAvailable,
      3: emptyUserHoursAvailable,
      4: emptyUserHoursAvailable,
      5: emptyUserHoursAvailable,
      6: emptyUserHoursAvailable,
    };

    _searchedUserDaysAvailable.setAllDays = this.daysAvailable;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(this._searchedGender);

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    Widget _buildSearchTF() {
      final width = MediaQuery.of(context).size.width;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            height: 30.0,
            width: width * 0.82,
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
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: IconButton(
              icon: Icon(Icons.filter_list),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () async {
                await showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  enableDrag: true,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return PlayNowFilter(
                      searchedDaysAvailable: this._searchedUserDaysAvailable,
                      searchedPositions: this._searchedPositions,
                      searchedGender: this._searchedGender,
                      searchedRange: this._searchedRange
                    );
                  },
                );

                setState(() {});
              },
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Center(
                  child: Container(
                    decoration: horizontalGradient,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidth = constraints.maxWidth;

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: horizontalGradient,
                                padding: EdgeInsets.only(left: 10.0, top: 33.0),
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
                                    bottom: 20.0, left: 20.0, right: 20.0),
                                margin: EdgeInsets.only(top: 20.0),
                                width: _width,
                                height: _height,
                                child: FutureBuilder(
                                  future: _playNowRepository.getUserOffers(
                                    this._searchedRange['distance'].toInt(),
                                    this._searchedGender,
                                    this._searchedPositions,
                                    daysAvailable,
                                  ),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    // return Container(
                                    //   width: _width,
                                    //   height: _height,
                                    // );

                                    if (!snapshot.hasData) {
                                      return Container(
                                        width: _width,
                                        height: _height,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [circularLoading],
                                        ),
                                      );
                                    }

                                    dynamic response = snapshot.data;
                                    if (response['success']) {
                                      List<dynamic> users = response['users'];
                                      return ListView.builder(
                                        itemCount: users.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return _buildPlayNowRow(users[index]);
                                        },
                                      );
                                    } else {
                                      return showAlert(
                                        context,
                                        'Error!',
                                        'Ocurrió un error cargar los jugadores!',
                                      );
                                    }

                                  },
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
          )
        ],
      ),
    );
  }

  void _navigateToSection(index) {
    switch (index) {
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => MatchesScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ChatsScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ProfileScreen(),
            transitionDuration: Duration(seconds: 0),
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
      currentIndex: 0,
      onTap: (index) {
        if (index != 0) {
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

  Widget _buildPlayNowRow(dynamic userJson) {
    User user = User.fromJson(userJson);
    final _width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PublicProfile(
            user: user,
          )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green[600],
              Colors.green[500],
              Colors.green[500],
              Colors.green[600],
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green[100],
              blurRadius: 6.0,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.green[400],
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        width: _width,
        height: 80.0,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.green[700],
                size: 40.0,
              ),
            ),
            title: Text(
              user.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }

}
