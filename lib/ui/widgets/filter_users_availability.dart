import 'dart:convert';

import 'package:app/bloc/profile/profile_bloc.dart';
import 'package:app/models/database/days_available.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/ui/widgets/hour_available.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class FilterUsersAvailability extends StatefulWidget {
  UserDaysAvailable userDaysAvailable;

  FilterUsersAvailability({Key key, this.userDaysAvailable}) : super(key: key);

  @override
  _FilterUsersAvailabilityState createState() => _FilterUsersAvailabilityState();
}

class _FilterUsersAvailabilityState extends State<FilterUsersAvailability> {
  bool _monday = true;
  bool _tuesday = true;
  bool _wednesday = true;
  bool _thursday = true;
  bool _friday = true;
  bool _saturday = true;
  bool _sunday = true;
  UserDaysAvailable _userDaysAvailable;

  @override
  void initState() {
    if (widget.userDaysAvailable.daysAvailable[0] == null) this._monday = false;
    if (widget.userDaysAvailable.daysAvailable[1] == null) this._tuesday = false;
    if (widget.userDaysAvailable.daysAvailable[2] == null) this._wednesday = false;
    if (widget.userDaysAvailable.daysAvailable[3] == null) this._thursday = false;
    if (widget.userDaysAvailable.daysAvailable[4] == null) this._friday = false;
    if (widget.userDaysAvailable.daysAvailable[5] == null) this._saturday = false;
    if (widget.userDaysAvailable.daysAvailable[6] == null) this._sunday = false;

    super.initState();
  }

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
                    'Cuando quieres jugar?',
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
                        'Selecciona el/los dias que quieres jugar y completa si tienes alguna incidencia horaria (Despues podras cambiar esta configuracion en tu perfil)',
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Domingo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _sunday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sunday = !_sunday;
                        });

                        if (_sunday) {
                          widget.userDaysAvailable.daysAvailable[0] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[0] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _sunday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_sunday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[0],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(0, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Lunes',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _monday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _monday = !_monday;
                        });

                        if (_monday) {
                          widget.userDaysAvailable.daysAvailable[1] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[1] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _monday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_monday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[1],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(1, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Martes',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _tuesday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _tuesday = !_tuesday;
                        });

                        if (_tuesday) {
                          widget.userDaysAvailable.daysAvailable[2] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[2] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _tuesday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_tuesday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[2],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(2, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Miercols',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _wednesday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _wednesday = !_wednesday;
                        });

                        if (_wednesday) {
                          widget.userDaysAvailable.daysAvailable[3] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[3] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _wednesday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_wednesday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[3],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(3, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Jueves',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _thursday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _thursday = !_thursday;
                        });

                        if (_thursday) {
                          widget.userDaysAvailable.daysAvailable[4] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[4] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _thursday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_thursday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[4],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(4, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Viernes',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _friday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _friday = !_friday;
                        });

                        if (_friday) {
                          widget.userDaysAvailable.daysAvailable[5] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[5] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _friday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_friday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[5],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(5, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Sabado',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 35,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _saturday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 25,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _saturday = !_saturday;
                        });

                        if (_saturday) {
                          widget.userDaysAvailable.daysAvailable[6] =
                              UserHoursAvailable(
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
                        } else {
                          widget.userDaysAvailable.daysAvailable[6] = null;
                        }
                      },
                    ),
                    IconButton(
                      icon: _saturday
                          ? Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.watch_later_outlined,
                      ),
                      onPressed: () async {
                        if (_saturday) {
                          final UserHoursAvailable hoursAvailable =
                          await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: false,
                            isScrollControlled: true,
                            isDismissible: false,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable:
                                widget.userDaysAvailable.daysAvailable[6],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            widget.userDaysAvailable
                                .setDaysAvailable(6, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
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
                        bool noDaysSelected = (widget.userDaysAvailable
                            .daysAvailable[0] ==
                            null &&
                            widget.userDaysAvailable.daysAvailable[1] == null &&
                            widget.userDaysAvailable.daysAvailable[2] == null &&
                            widget.userDaysAvailable.daysAvailable[3] == null &&
                            widget.userDaysAvailable.daysAvailable[4] == null &&
                            widget.userDaysAvailable.daysAvailable[5] == null &&
                            widget.userDaysAvailable.daysAvailable[6] == null);

                        if (noDaysSelected) {
                          return showAlert(
                            context,
                            'Atencion!',
                            'Debes seleccionar alguna disponibilidad de dia y horario para poder filtrar',
                          );
                        } else {
                          Navigator.pop(context, widget.userDaysAvailable);
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
