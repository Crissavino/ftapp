import 'package:app/models/user_positions.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class FilterUserPositions extends StatefulWidget {

  UserPositions searchedPositions;

  FilterUserPositions({Key key, this.searchedPositions}) : super(key: key);

  @override
  _FilterUserPositionsState createState() => _FilterUserPositionsState();
}

class _FilterUserPositionsState extends State<FilterUserPositions> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height / 1.4,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                ListTile(
                  leading: Text(
                    'Que posiciones buscas?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    padding: EdgeInsets.only(
                      left: 15.0,
                    ),
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      showAlert(
                        context,
                        'Informacion',
                        'Selecciona la/las posiciones que estas buscando',
                      );
                    },
                  ),
                ),
                GFCheckboxListTile(
                  title: Center(
                    child: Text(
                      'Arquero',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  avatar: GFAvatar(
                    backgroundImage:
                    AssetImage('assets/icons/primary/007-goalkeeper.png'),
                    size: 45.0,
                  ),
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  padding: EdgeInsets.all(0),
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.searchedPositions.goalKeeper = !widget.searchedPositions.goalKeeper;
                    });
                  },
                  value: widget.searchedPositions.goalKeeper,
                  inactiveIcon: null,
                ),
                GFCheckboxListTile(
                  title: Center(
                    child: Text(
                      'Defensor',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  avatar: GFAvatar(
                    backgroundImage: AssetImage('assets/icons/primary/005-pads.png'),
                    size: 45.0,
                  ),
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  padding: EdgeInsets.all(0),
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.searchedPositions.defense = !widget.searchedPositions.defense;
                    });
                  },
                  value: widget.searchedPositions.defense,
                  inactiveIcon: null,
                ),
                GFCheckboxListTile(
                  title: Center(
                    child: Text(
                      'Mediocampista',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  avatar: GFAvatar(
                    backgroundImage:
                    AssetImage('assets/icons/primary/006-footwear.png'),
                    size: 45.0,
                  ),
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  padding: EdgeInsets.all(0),
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.searchedPositions.midfielder = !widget.searchedPositions.midfielder;
                    });
                  },
                  value: widget.searchedPositions.midfielder,
                  inactiveIcon: null,
                ),
                GFCheckboxListTile(
                  title: Center(
                    child: Text(
                      'Delantero',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  avatar: GFAvatar(
                    backgroundImage:
                    AssetImage('assets/icons/primary/013-football-1.png'),
                    size: 45.0,
                  ),
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  padding: EdgeInsets.all(0),
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.searchedPositions.forward = !widget.searchedPositions.forward;
                    });
                  },
                  value: widget.searchedPositions.forward,
                  inactiveIcon: null,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
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
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.green[400],
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  width: _width * .40,
                  height: 50.0,
                  child: Center(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        bool noPositionSelected = (
                            !widget.searchedPositions.goalKeeper &&
                            !widget.searchedPositions.defense &&
                            !widget.searchedPositions.midfielder &&
                            !widget.searchedPositions.forward
                        );

                        if (noPositionSelected) {
                          return showAlert(
                            context,
                            'Atencion!',
                            'Debes seleccionar alguna posicion para poder filtrar',
                          );
                        } else {
                          Navigator.pop(context, widget.searchedPositions);
                        }
                      },
                      child: Text(
                        'Listo'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
