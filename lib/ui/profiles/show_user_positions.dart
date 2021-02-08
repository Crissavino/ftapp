import 'package:app/models/database/position.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

class ShowUserPositions extends StatefulWidget {

  final List<Position> userPositions;
  const ShowUserPositions({Key key, this.userPositions}) : super(key: key);

  @override
  _ShowUserPositionsState createState() => _ShowUserPositionsState();
}

class _ShowUserPositionsState extends State<ShowUserPositions> {
  bool _gkPos = false;
  bool _defPos = false;
  bool _mfPos = false;
  bool _forPos = false;

  @override
  void initState() {
    widget.userPositions.forEach((Position element) {
      if (element.position == 'goalKeeper') {
        this._gkPos = true;
      }

      if (element.position == 'defense') {
        this._defPos = true;
      }

      if (element.position == 'midfielder') {
        this._mfPos = true;
      }

      if (element.position == 'forward') {
        this._forPos = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height / 1.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (this._gkPos) Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFAvatar(
                        backgroundImage: AssetImage(
                            'assets/icons/primary/007-goalkeeper.png'),
                        size: 45.0,
                      ),
                      SizedBox(width: 20.0,),
                      Center(
                        child: Text(
                          'Arquero',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
            if (this._defPos) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/005-pads.png'),
                  size: 45.0,
                ),
                SizedBox(width: 20.0,),
                Center(
                  child: Text(
                    'Defensor',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            if (this._mfPos) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/006-footwear.png'),
                  size: 45.0,
                ),
                SizedBox(width: 20.0,),
                Center(
                  child: Text(
                    'Mediocampista',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            if (this._forPos) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFAvatar(
                  backgroundImage: AssetImage(
                      'assets/icons/primary/013-football-1.png'),
                  size: 45.0,
                ),
                SizedBox(width: 20.0,),
                Center(
                  child: Text(
                    'Delantero',
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
