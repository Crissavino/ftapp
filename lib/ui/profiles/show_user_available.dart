import 'dart:convert';

import 'package:app/models/database/days_available.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/ui/profiles/show_user_hours_available.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

class ShowUserAvailable extends StatefulWidget {

  final List<DaysAvailable> userDaysAvailable;
  const ShowUserAvailable({Key key, this.userDaysAvailable}) : super(key: key);

  @override
  _ShowUserAvailableState createState() => _ShowUserAvailableState();
}

class _ShowUserAvailableState extends State<ShowUserAvailable> {
  bool _monday = false;
  bool _tuesday = false;
  bool _wednesday = false;
  bool _thursday = false;
  bool _friday = false;
  bool _saturday = false;
  bool _sunday = false;
  UserDaysAvailable _userDaysAvailable;

  @override
  void initState() {
    this._userDaysAvailable = UserDaysAvailable();
    if (widget.userDaysAvailable[0].dayOfTheWeek == 0 &&
        widget.userDaysAvailable[0].available != null) {
      _sunday = true;
    }
    if (_sunday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[0].available));
      this._userDaysAvailable.daysAvailable[0] = available;
    }
    if (widget.userDaysAvailable[1].dayOfTheWeek == 1 &&
        widget.userDaysAvailable[1].available != null) {
      _monday = true;
    }
    if (_monday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[1].available));
      this._userDaysAvailable.daysAvailable[1] = available;
    }
    if (widget.userDaysAvailable[2].dayOfTheWeek == 2 &&
        widget.userDaysAvailable[2].available != null) {
      _tuesday = true;
    }
    if (_tuesday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[2].available));
      this._userDaysAvailable.daysAvailable[2] = available;
    }
    if (widget.userDaysAvailable[3].dayOfTheWeek == 3 &&
        widget.userDaysAvailable[3].available != null) {
      _wednesday = true;
    }
    if (_wednesday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[3].available));
      this._userDaysAvailable.daysAvailable[3] = available;
    }
    if (widget.userDaysAvailable[4].dayOfTheWeek == 4 &&
        widget.userDaysAvailable[4].available != null) {
      _thursday = true;
    }
    if (_thursday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[4].available));
      this._userDaysAvailable.daysAvailable[4] = available;
    }
    if (widget.userDaysAvailable[5].dayOfTheWeek == 5 &&
        widget.userDaysAvailable[5].available != null) {
      _friday = true;
    }
    if (_friday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[5].available));
      this._userDaysAvailable.daysAvailable[5] = available;
    }
    if (widget.userDaysAvailable[6].dayOfTheWeek == 6 &&
        widget.userDaysAvailable[6].available != null) {
      _saturday = true;
    }
    if (_saturday) {
      UserHoursAvailable available = UserHoursAvailable.fromJson(
          jsonDecode(widget.userDaysAvailable[6].available));
      this._userDaysAvailable.daysAvailable[6] = available;
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
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
                      onPressed: () {
                        if (_sunday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[0],
                              );
                            },
                          );
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
                      onPressed: () {
                        if (_monday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[1],
                              );
                            },
                          );
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
                      onPressed: () {
                        if (_tuesday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[2],
                              );
                            },
                          );
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
                      onPressed: () {
                        if (_wednesday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[3],
                              );
                            },
                          );
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
                      onPressed: () {
                        if (_thursday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[4],
                              );
                            },
                          );
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
                      onPressed: () {
                        if (_friday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[5],
                              );
                            },
                          );
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
                      onPressed: ()  {
                        if (_saturday) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ShowUserHoursAvailable(
                                userHoursAvailable:
                                this._userDaysAvailable.daysAvailable[6],
                              );
                            },
                          );

                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
