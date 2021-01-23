import 'dart:io';

import 'package:app/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:app/models/database/user.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_location.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/services/place_service.dart';
import 'package:app/ui/search/search_location.dart';
import 'package:app/ui/widgets/hour_available.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen_bottom_navigation_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  UserRepository _userRepository = UserRepository();
  User user;

  // text field state
  String localeName = Platform.localeName.split('_')[0];
  bool _gkPos = false;
  bool _defPos = false;
  bool _mfPos = false;
  bool _forPos = false;
  bool _monday = false;
  bool _tuesday = false;
  bool _wednesday = false;
  bool _thursday = false;
  bool _friday = false;
  bool _saturday = false;
  bool _sunday = false;
  PageController _pageController;
  List<Widget> slideList;
  int initialPage;
  String userLocationDesc = '';
  UserLocation userLocationDetails;
  UserDaysAvailable _userDaysAvailable;

  @override
  void initState() {
    this._userDaysAvailable = UserDaysAvailable();
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // section 1
    Widget _buildPositionsCheckboxes() {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        child: Column(
          children: [
            ListTile(
              leading: Text(
                'Cual es tu pisicion?',
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
                    'Selecciona la/las posiciones en la que sueles jugar (Despues podras cambiar esta configuracion en tu perfil)',
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
                  _gkPos = !_gkPos;
                });
              },
              value: _gkPos,
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
                  _defPos = !_defPos;
                });
              },
              value: _defPos,
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
                  _mfPos = !_mfPos;
                });
              },
              value: _mfPos,
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
                  _forPos = !_forPos;
                });
              },
              value: _forPos,
              inactiveIcon: null,
            )
          ],
        ),
      );
    }

    Widget _buildSearchLocationBar() {
      return GestureDetector(
        onTap: () async {
          final Suggestion result =
          await showSearch(context: context, delegate: SearchLocation());

          if (result != null) {
            BlocProvider.of<CompleteProfileBloc>(context).add(
                ProfileCompleteUserLocationLoadedEvent()
            );
            setState(() {
              userLocationDesc = result.description;
              userLocationDetails = result.details;
            });
          }
        },
        child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
          builder: (BuildContext context, state) {

            if (state is ProfileCompleteLoadingUserLocationState) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    circularLoading
                  ],
                ),
              );
            }

            return Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 50.0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 13.0,
                ),
                width: double.infinity,
                child: Text(
                  userLocationDesc.isEmpty ? 'Ubicacion...' : userLocationDesc,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      );
    }

    Widget _buildWhereToPlay() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Donde quieres jugar?',
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
                        'Selecciona el lugar en el que habitualmente juegas (Despues podras cambiar esta configuracion en tu perfil)',
                      );
                    },
                  ),
                ),
                _buildSearchLocationBar(),
              ],
            ),
          ),
        ],
      );
    }
    // section 1

    // section 2
    Widget _buildHourlyIncidence() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            child: Column(
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _sunday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sunday = !_sunday;
                        });

                        if (_sunday) {
                          this._userDaysAvailable.daysAvailable[0] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[0] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[0],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(0, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _monday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _monday = !_monday;
                        });

                        if (_monday) {
                          this._userDaysAvailable.daysAvailable[1] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[1] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[1],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(1, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _tuesday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _tuesday = !_tuesday;
                        });

                        if (_tuesday) {
                          this._userDaysAvailable.daysAvailable[2] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[2] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[2],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(2, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _wednesday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _wednesday = !_wednesday;
                        });

                        if (_wednesday) {
                          this._userDaysAvailable.daysAvailable[3] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[3] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[3],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(3, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _thursday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _thursday = !_thursday;
                        });

                        if (_thursday) {
                          this._userDaysAvailable.daysAvailable[4] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[4] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[4],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(4, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _friday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _friday = !_friday;
                        });

                        if (_friday) {
                          this._userDaysAvailable.daysAvailable[5] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[5] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[5],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(5, hoursAvailable);
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
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GFCheckbox(
                      size: 30,
                      activeBgColor: Colors.green[400],
                      inactiveBorderColor: Colors.green[700],
                      activeBorderColor: Colors.green[700],
                      type: GFCheckboxType.circle,
                      value: _saturday,
                      inactiveIcon: null,
                      activeIcon: Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _saturday = !_saturday;
                        });

                        if (_saturday) {
                          this._userDaysAvailable.daysAvailable[6] = UserHoursAvailable(
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
                          this._userDaysAvailable.daysAvailable[6] = null;
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
                          final UserHoursAvailable hoursAvailable = await showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            enableDrag: true,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return HourAvailable(
                                userHoursAvailable: this._userDaysAvailable.daysAvailable[6],
                              );
                            },
                          );

                          if (hoursAvailable != null) {
                            this._userDaysAvailable.setDaysAvailable(6, hoursAvailable);
                          }
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    // section 2

    List<Widget> slides() {
      slideList = [
        Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: verticalGradient,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // _buildPage1Title(),
                          SizedBox(height: 20.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildPositionsCheckboxes(),
                                SizedBox(height: 20.0),
                                _buildWhereToPlay(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: verticalGradient,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // _buildPage2Title(),
                          // SizedBox(
                          //   height: 30.0,
                          // ),
                          Form(
                            key: _formKey2,
                            child: Column(
                              children: [
                                _buildHourlyIncidence(),
                                // SizedBox(
                                //   height: 30.0,
                                // ),
                                // _buildWhereToPlay(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ];
      return slideList;
    }

    return SafeArea(
      top: false,
      child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
        builder: (BuildContext context, state) {

          if (state is ProfileCompleteLoadingState) {
            return GFIntroScreen(
              color: Colors.blueGrey,
              slides: [
                Container(
                  decoration: verticalGradient,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      whiteCircularLoading
                    ],
                  ),
                )
              ],
              pageController: _pageController,
              currentIndex: 0,
              pageCount: 2,
              introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
                pageController: _pageController,
                pageCount: slideList.length,
                currentIndex: initialPage,
                onForwardButtonTap: null,
                onBackButtonTap: null,
                onDoneTap: null,
                dotWidth: 10.0,
                dotHeight: 10.0,
                navigationBarHeight: 0.0,
                navigationBarColor: Colors.white,
                showDivider: false,
                skipButton: Container(),
                inactiveColor: Colors.grey[200],
                activeColor: GFColors.SUCCESS,
              ),
            );
          }

          return GFIntroScreen(
            color: Colors.blueGrey,
            slides: slides(),
            pageController: _pageController,
            currentIndex: 0,
            pageCount: 2,
            introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
              pageController: _pageController,
              pageCount: slideList.length,
              currentIndex: initialPage,
              onForwardButtonTap: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              onBackButtonTap: () {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              onDoneTap: () async {
                bool noPositionSelected = (!_gkPos && !_defPos && !_mfPos && !_forPos);
                bool noDaysSelected = (
                    this._userDaysAvailable.daysAvailable[0] == null &&
                        this._userDaysAvailable.daysAvailable[1] == null &&
                        this._userDaysAvailable.daysAvailable[2] == null &&
                        this._userDaysAvailable.daysAvailable[3] == null &&
                        this._userDaysAvailable.daysAvailable[4] == null &&
                        this._userDaysAvailable.daysAvailable[5] == null &&
                        this._userDaysAvailable.daysAvailable[6] == null
                );

                BlocProvider.of<CompleteProfileBloc>(context).add(
                    ProfileCompleteLoadingEvent()
                );

                if(noPositionSelected) {
                  BlocProvider.of<CompleteProfileBloc>(context).add(
                      ProfileCompleteErrorEvent()
                  );
                  return showAlert(
                    context,
                    'Atencion!',
                    'Debes seleccionar alguna posicion en la que usualmente juegas',
                  );
                } else if (userLocationDesc.isEmpty){
                  BlocProvider.of<CompleteProfileBloc>(context).add(
                      ProfileCompleteErrorEvent()
                  );
                  return showAlert(
                    context,
                    'Atencion!',
                    'Debes seleccionar algun lugar en el que usualmente juegas',
                  );
                } else if (noDaysSelected) {
                  BlocProvider.of<CompleteProfileBloc>(context).add(
                      ProfileCompleteErrorEvent()
                  );
                  return showAlert(
                    context,
                    'Atencion!',
                    'Debes seleccionar alguna disponibilidad de dia y horario para poder jugar',
                  );
                }

                UserPositions userPositions = UserPositions(
                  goalKeeper: _gkPos,
                  defense: _defPos,
                  midfielder: _mfPos,
                  forward: _forPos,
                );

                final completeUserProfileResponse = await _userRepository.completeUserProfile(
                  userPositions,
                  userLocationDetails,
                  this._userDaysAvailable.daysAvailable,
                );

                if (completeUserProfileResponse['success'] == true) {
                  Navigator.pushReplacementNamed(context, 'matches');

                  BlocProvider.of<CompleteProfileBloc>(context).add(
                      ProfileCompletedEvent()
                  );
                } else {
                  BlocProvider.of<CompleteProfileBloc>(context).add(
                      ProfileCompleteErrorEvent()
                  );
                  return showAlert(
                    context,
                    'Error!',
                    'Ocurrió un error al completar el perfil!',
                  );
                }
              },
              dotWidth: 10.0,
              dotHeight: 10.0,
              navigationBarColor: Colors.white,
              showDivider: false,
              skipButton: Container(),
              inactiveColor: Colors.grey[200],
              activeColor: GFColors.SUCCESS,
            ),
          );
        },
      ),
    );
  }
}
