import 'package:app/ui/chats/chats_screen.dart';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/play_now/play_now_screen.dart';
import 'package:app/ui/profiles/profile_screen.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/slide_bottom_route.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int currentIndex = 1;
  dynamic search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.currentIndex == 3
          ? null
          : AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: horizontalGradient,
          padding: EdgeInsets.only(left: 10.0, top: 33.0),
          alignment: Alignment.center,
          child: (this.currentIndex == 0 || this.currentIndex == 1)
              ? _buildSearchTF()
              : this.currentIndex == 2
              ? Text(
            'Mis chats',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 26.0,
            ),
          )
              : Text(
            'Mi perfil',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 26.0,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: horizontalGradient,
        child: this.currentIndex != 3 ? SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
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
            child: ClipRRect(
              borderRadius: screenBorders,
              child: _callSection(currentIndex),
            ),
          ),
        ) : SafeArea(child: _callSection(currentIndex)),
      ),
      bottomNavigationBar: Container(
        decoration: (currentIndex != 0)
            ? BoxDecoration(color: Colors.white)
            : horizontalGradient,
        child: _buildBottomNavigationBarRounded(),
      ),
    );
  }

  Container _buildPlayNowPostButton() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.add_circle_outline),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {
          print('Crear un post para jugar ahora');
        },
      ),
    );
  }

  Container _buildCreateMatchButton() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.add_circle_outline),
        iconSize: 30.0,
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            SlideBottomRoute(
              page: MatchesScreen(),
            ),
          ).then((val) async {
            setState(() {});
          });
        },
      ),
    );
  }

  Widget _buildAddButton(int index) {
    switch (index) {
      case 0:
        return _buildPlayNowPostButton();
        break;
      case 1:
        return _buildCreateMatchButton();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      default:
        return _buildCreateMatchButton();
        break;
    }
  }

  Widget _buildSearchTF() {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
        _buildAddButton(this.currentIndex),
      ],
    );
  }

  _callSection(int actualPage) {
    switch (actualPage) {
      case 0:
        return PlayNowScreen();
      case 1:
        return SafeArea(
          child: MatchesScreen(),
        );
        break;
      case 2:
        return SafeArea(
          child: ChatsScreen(),
        );
        break;
      case 3:
        return SafeArea(
          child: ProfileScreen(),
        );
        break;
      default:
        return SafeArea(
          child: ChatsScreen(),
        );
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
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
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
