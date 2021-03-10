import 'package:app/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:app/models/user_location.dart';
import 'package:app/repositories/create_match_repository.dart';
import 'package:app/services/place_service.dart';
import 'package:app/ui/search/search_location.dart';
import 'package:app/ui/widgets/create_match/build_sex.dart';
import 'package:app/ui/widgets/create_match/build_what_positions.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

import 'create_match/build_type.dart';

class CreateMatchPost extends StatefulWidget {
  @override
  _CreateMatchPostState createState() => _CreateMatchPostState();
}

class _CreateMatchPostState extends State<CreateMatchPost> {
  String userLocationDesc = '';
  UserLocation matchLocation;
  String whenPlay = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );
  Map<String, bool> gender = {
    'men': true,
    'women': false,
    'mix': false,
  };
  Map<String, bool> matchType = {
    'f5': true,
    'f7': false,
    'f9': false,
    'f11': false,
  };
  Map<String, int> whatPositions = {
    'goalKeeper': 0,
    'defense': 0,
    'midfielder': 0,
    'forward': 0,
  };

  int cost = 0;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    print(_height);
    final _width = MediaQuery.of(context).size.width;

    _buildName() {
      return Container(
        child: Text(
          'Crear partido',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Nunito', fontSize: 30.0),
        ),
      );
    }

    Widget _buildSearchLocationBar() {
      return GestureDetector(
        onTap: () async {
          final Suggestion result =
              await showSearch(context: context, delegate: SearchLocation());

          if (result != null) {
            BlocProvider.of<CompleteProfileBloc>(context)
                .add(ProfileCompleteUserLocationLoadedEvent());
            setState(() {
              userLocationDesc = result.description;
              matchLocation = result.details;
            });
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          width: _width * .95,
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
          height: 60.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 13.0,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 30.0,
                  color: Colors.green[400],
                ),
                SizedBox(
                  width: 10.0,
                ),
                userLocationDesc.isEmpty
                    ? Text(
                        'Donde se juega?',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )
                    : Expanded(
                        child: Text(
                          userLocationDesc,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    }

    Future<bool> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        locale: Locale('es', 'ES'),
        context: context,
        initialDate: this.selectedDate,
        firstDate: DateTime(2021, this.selectedDate.month),
        lastDate: DateTime(this.selectedDate.year + 1),
      );
      if (picked != null) {
        setState(() {
          this.selectedDate = picked;
        });
        return true;
      } else {
        return false;
      }
    }

    Future<bool> _selectTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: this.selectedTime,
      );
      if (picked != null) {
        setState(() {
          this.selectedTime = picked;
        });
        return true;
      } else {
        return false;
      }
    }

    Widget _buildWhenPlay() {
      return GestureDetector(
        onTap: () async {
          _selectDate(context).then((value) {
            if (value) {
              _selectTime(context).then((value) {
                if (value) {
                  this.whenPlay =
                      '${this.selectedDate.day}/${this.selectedDate.month}/${this.selectedDate.year} ${this.selectedTime.hour}:${this.selectedTime.minute}';
                }
              });
            }
          });
        },
        child: Container(
          alignment: Alignment.centerLeft,
          width: _width * .95,
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
          height: 60.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 13.0,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 30.0,
                  color: Colors.green[400],
                ),
                SizedBox(
                  width: 10.0,
                ),
                this.whenPlay.isEmpty
                    ? Text(
                        'Cuando se juega?',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      )
                    : Expanded(
                        child: Text(
                          this.whenPlay,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildSex() {
      return GestureDetector(
        child: Container(
          width: _width * .95,
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
          child: ListTile(
            title: Text('Que genero juegan?'),
            trailing: Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 40.0,
            ),
          ),
        ),
        onTap: () async {
          await showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            enableDrag: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return BuildSex(gender: this.gender);
            },
          );
        },
      );
    }

    Widget _buildType() {
      return GestureDetector(
        child: Container(
          width: _width * .95,
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
          child: ListTile(
            title: Text('Que tipo de partido es?'),
            trailing: Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 40.0,
            ),
          ),
        ),
        onTap: () async {
          final wasSavedData = await showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            enableDrag: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return BuildType(matchType: this.matchType);
            },
          );
        },
      );
    }

    Widget _buildCost() {
      return Container(
        alignment: Alignment.centerLeft,
        width: _width * .95,
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
        height: 60.0,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          style: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.attach_money,
              color: Colors.green[400],
            ),
            hintText: "Costo aproximado",
            hintStyle: kHintTextStyle,
          ),
          onChanged: (val) {
            if (val.isEmpty) {
              setState(() => this.cost = 0);
            } else {
              setState(() => this.cost = int.parse(val));
            }
          },
        ),
      );
    }

    Widget _buildWhatPositions() {
      return GestureDetector(
        child: Container(
          width: _width * .95,
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
          child: ListTile(
            title: Text('Que posicion buscas?'),
            trailing: Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 40.0,
            ),
          ),
        ),
        onTap: () async {
          final wasSavedData = await showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            enableDrag: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return BuildWhatPositions(
                whatPositions: this.whatPositions,
              );
            },
          );

          if (wasSavedData == true) {
            // this._userPositions = await _userRepository.getUserPositions();
          }
        },
      );
    }

    Widget _buildButton() {
      return Container(
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
          child: TextButton(
            onPressed: () async {
              if (this.userLocationDesc == '') {
                return showAlert(
                  context,
                  'Atencion!',
                  'Debes indicar el lugar donde se juega el partido',
                );
              }

              if (this.whenPlay == '') {
                return showAlert(
                  context,
                  'Atencion!',
                  'Debes indicar cuando se va a jugar el partido',
                );
              }

              if (this.cost == 0) {
                return showAlert(
                  context,
                  'Atencion!',
                  'Debes indicar el costo aproximado',
                );
              }

              bool isAllPositionsEmpty =
                  this.whatPositions['goalKeeper'] == 0 &&
                      this.whatPositions['defense'] == 0 &&
                      this.whatPositions['midfielder'] == 0 &&
                      this.whatPositions['forward'] == 0;

              if (isAllPositionsEmpty) {
                return showAlert(
                  context,
                  'Atencion!',
                  'Debes indicar alguna posicion buscada',
                );
              }

              final response = await CreateMatchRepository().createMatch(
                this.gender,
                this.whenPlay,
                this.matchType,
                this.whatPositions,
                this.matchLocation,
                this.cost,
              );
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
      );
    }

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: _height / 1.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildName(),
              _buildSearchLocationBar(),
              _buildWhenPlay(),
              _buildSex(),
              _buildType(),
              _buildCost(),
              _buildWhatPositions(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
