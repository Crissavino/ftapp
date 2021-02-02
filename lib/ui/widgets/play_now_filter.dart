import 'dart:io';

import 'package:app/models/database/days_available.dart';
import 'package:app/models/database/location.dart';
import 'package:app/models/database/position.dart';
import 'package:app/models/user_days_available.dart';
import 'package:app/models/user_hours_available.dart';
import 'package:app/models/user_positions.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/ui/widgets/filter_users_availability.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayNowFilter extends StatefulWidget {
  @override
  _PlayNowFilterState createState() => _PlayNowFilterState();
}

class _PlayNowFilterState extends State<PlayNowFilter> {
  UserRepository _userRepository = UserRepository();
  UserPositions searchedPositions;
  UserDaysAvailable _userDaysAvailable;
  dynamic _userDaysAvailable2;
  bool isMale;
  bool isMix;
  int range;
  Location _userLocation;

  // text field state
  String localeName = Platform.localeName.split('_')[0];

  @override
  void initState() {
    this._userDaysAvailable = UserDaysAvailable();
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

    print('entra');

    UserPositions searchedPositions = UserPositions(
      goalKeeper: true,
      defense: true,
      midfielder: true,
      forward: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    // filtrar por sexo o mixto
    // filtrar por posiciones
    // filtrar por distancia maxima
    // filtrar por disponibilidad
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
            SizedBox(height: 20.0),
            _buildName(),
            SizedBox(height: 5.0),
            _buildFilterDaysAvailable(),
            SizedBox(height: 10.0),
            _buildFilterButton(),
          ],
        )
        );
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
              userDaysAvailable: this._userDaysAvailable,
            );
          },
        );

        if (filterDays != null) {
          this._userDaysAvailable = filterDays;
          print(this._userDaysAvailable.daysAvailable);
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
        child: FlatButton(
          splashColor: Colors.transparent,
          onPressed: () async {
            bool noPositionSelected = (!searchedPositions.goalKeeper && !searchedPositions.defense && !searchedPositions.midfielder && !searchedPositions.forward);
            bool noDaysSelected = (
                this._userDaysAvailable.daysAvailable[0] == null &&
                    this._userDaysAvailable.daysAvailable[1] == null &&
                    this._userDaysAvailable.daysAvailable[2] == null &&
                    this._userDaysAvailable.daysAvailable[3] == null &&
                    this._userDaysAvailable.daysAvailable[4] == null &&
                    this._userDaysAvailable.daysAvailable[5] == null &&
                    this._userDaysAvailable.daysAvailable[6] == null
            );

            // BlocProvider.of<CompleteProfileBloc>(context).add(
            //     ProfileCompleteLoadingEvent()
            // );

            if(noPositionSelected) {
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

            // llenar con lo que devuelve una vez filtrado
            // UserPositions userPositions = UserPositions(
            //   goalKeeper: _gkPos,
            //   defense: _defPos,
            //   midfielder: _mfPos,
            //   forward: _forPos,
            // );

            // bool isMale = _male;

            // final completeUserProfileResponse = await _userRepository.completeUserProfile(
            //     userPositions,
            //     userLocationDetails,
            //     this._userDaysAvailable.daysAvailable,
            //     isMale
            // );
            //
            // if (completeUserProfileResponse['success'] == true) {
            //   Navigator.pushReplacementNamed(context, 'matches');
            //
            //   BlocProvider.of<CompleteProfileBloc>(context).add(
            //       ProfileCompletedEvent()
            //   );
            // } else {
            //   BlocProvider.of<CompleteProfileBloc>(context).add(
            //       ProfileCompleteErrorEvent()
            //   );
            //   return showAlert(
            //     context,
            //     'Error!',
            //     'Ocurrió un error al completar el perfil!',
            //   );
            // }
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
