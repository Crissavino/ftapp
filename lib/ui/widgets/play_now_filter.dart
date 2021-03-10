import 'dart:io';

import 'package:app/models/database/days_available.dart';
import 'package:app/models/database/location.dart';
import 'package:app/models/database/position.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/repositories/play_now_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/ui/widgets/custom_slider.dart';
import 'package:app/ui/widgets/filter_user_positions.dart';
import 'package:app/ui/widgets/filter_users_availability.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class PlayNowFilter extends StatefulWidget {
  UserDaysAvailable searchedDaysAvailable;
  UserPositions searchedPositions;
  Map<String, bool> searchedGender;
  Map<String, double> searchedRange;

  PlayNowFilter({
    Key key,
    this.searchedDaysAvailable,
    this.searchedPositions,
    this.searchedGender,
    this.searchedRange,
  }) : super(key: key);

  @override
  _PlayNowFilterState createState() => _PlayNowFilterState();
}

class _PlayNowFilterState extends State<PlayNowFilter> {
  UserRepository _userRepository = UserRepository();
  UserDaysAvailable _userDaysAvailable;

  // text field state
  String localeName = Platform.localeName.split('_')[0];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Container(
        height: _height / 1.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.0),
            _buildName(),
            // SizedBox(height: 5.0),
            _buildFilterDistance(),
            // SizedBox(height: 5.0),
            _buildFilterBySex(),
            SizedBox(height: 5.0),
            _buildFilterDaysAvailable(),
            // SizedBox(height: 5.0),
            _buildFilterPositions(),
            // SizedBox(height: 5.0),
            _buildFilterButton(),
            SizedBox(height: 10.0),
          ],
        ));
  }

  _buildName() {
    return Text(
      'Filtrar jugadores',
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Nunito',
        fontSize: 30.0,
      ),
    );
  }

  _buildFilterDistance() {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Distancia',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text('${widget.searchedRange['distance']} km'),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.green[700],
            inactiveTrackColor: Colors.green[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 4.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.green,
            overlayColor: Colors.green.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.green[700],
            inactiveTickMarkColor: Colors.green[100],
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.green,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          child: Slider(
            value: widget.searchedRange['distance'],
            min: 0,
            max: 100,
            divisions: 10,
            label: widget.searchedRange['distance'].toString(),
            onChanged: (value) {
              setState(
                    () {
                  widget.searchedRange['distance'] = value;
                },
              );
              print(widget.searchedRange['distance']);
            },
          ),
        ),
        // CustomSlider(
        //   sliderValue: widget.searchedRange,
        // ),
      ],
    );
  }

  _buildFilterBySex() {
    return Column(
      children: [
        Text(
          'Género',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Hombre',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.searchedGender['men'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.searchedGender['men'] =
                    !widget.searchedGender['men'];
                    if (!widget.searchedGender['men'] && !value) {
                      widget.searchedGender['women'] = true;
                    } else {
                      widget.searchedGender['women'] = false;
                      widget.searchedGender['mix'] = false;
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Mujer',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.searchedGender['women'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    widget.searchedGender['women'] =
                    !widget.searchedGender['women'];
                    if (!widget.searchedGender['women'] && !value) {
                      widget.searchedGender['men'] = true;
                    } else {
                      widget.searchedGender['men'] = false;
                      widget.searchedGender['mix'] = false;
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Mixto',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GFCheckbox(
                  size: 35,
                  activeBgColor: Colors.green[400],
                  inactiveBorderColor: Colors.green[700],
                  activeBorderColor: Colors.green[700],
                  type: GFCheckboxType.circle,
                  value: widget.searchedGender['mix'],
                  inactiveIcon: null,
                  activeIcon: Icon(
                    Icons.sports_soccer,
                    size: 25,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.searchedGender['mix'] =
                      !widget.searchedGender['mix'];
                      if (!widget.searchedGender['mix'] && !value) {
                        widget.searchedGender['men'] = true;
                      } else {
                        widget.searchedGender['men'] = false;
                        widget.searchedGender['women'] = false;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(width: 5.0,)
          ],
        ),
      ],
    );
  }

  _buildFilterPositions() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * .95,
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
          title: Text('Posiciones'),
          trailing: Icon(
            Icons.keyboard_arrow_up_outlined,
            size: 40.0,
          ),
        ),
      ),
      onTap: () async {
        final filterPositions = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FilterUserPositions(
              searchedPositions: widget.searchedPositions,
            );
          },
        );

        if (filterPositions != null) {
          widget.searchedPositions = filterPositions;
        }
      },
    );
  }

  _buildFilterDaysAvailable() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * .95,
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
          title: Text('Disponibilidad'),
          trailing: Icon(
            Icons.keyboard_arrow_up_outlined,
            size: 40.0,
          ),
        ),
      ),
      onTap: () async {
        final filterDays = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FilterUsersAvailability(
              userDaysAvailable: widget.searchedDaysAvailable,
            );
          },
        );

        if (filterDays != null) {
          widget.searchedDaysAvailable = filterDays;
        }
      },
    );
  }

  _buildFilterButton() {
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
      width: MediaQuery.of(context).size.width * .40,
      height: 50.0,
      child: Center(
        child: TextButton(
          onPressed: () async {
            bool noPositionSelected = (!widget.searchedPositions.goalKeeper &&
                !widget.searchedPositions.defense &&
                !widget.searchedPositions.midfielder &&
                !widget.searchedPositions.forward);
            bool noDaysSelected =
                (widget.searchedDaysAvailable.daysAvailable[0] == null &&
                    widget.searchedDaysAvailable.daysAvailable[1] == null &&
                    widget.searchedDaysAvailable.daysAvailable[2] == null &&
                    widget.searchedDaysAvailable.daysAvailable[3] == null &&
                    widget.searchedDaysAvailable.daysAvailable[4] == null &&
                    widget.searchedDaysAvailable.daysAvailable[5] == null &&
                    widget.searchedDaysAvailable.daysAvailable[6] == null);

            // BlocProvider.of<CompleteProfileBloc>(context).add(
            //     ProfileCompleteLoadingEvent()
            // );

            if (noPositionSelected) {
              // BlocProvider.of<CompleteProfileBloc>(context).add(
              //     ProfileCompleteErrorEvent()
              // );
              return showAlert(
                context,
                'Atencion!',
                'Debes seleccionar alguna posicion en la que usualmente juegas',
              );
            } else if (noDaysSelected) {
              // BlocProvider.of<CompleteProfileBloc>(context).add(
              //     ProfileCompleteErrorEvent()
              // );
              return showAlert(
                context,
                'Atencion!',
                'Debes seleccionar alguna disponibilidad de dia y horario para poder jugar',
              );
            }

            dynamic filterResponse = await PlayNowRepository().getUserOffers(
              widget.searchedRange['distance'].toInt(),
              widget.searchedGender,
              widget.searchedPositions,
              widget.searchedDaysAvailable.daysAvailable,
            );

            if (filterResponse['success']) {
              List<dynamic> users = filterResponse['users'];
              Navigator.pop(context, users);
            } else {
              return showAlert(
                context,
                'Error!',
                'Ocurrió un error cargar los jugadores!',
              );
            }
          },
          child: Text(
            'Filtrar'.toUpperCase(),
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
}
