import 'dart:io';

import 'package:app/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:app/models/user.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/show_alert.dart';
import 'package:app/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  UserRepository _userRepository = UserRepository();
  User user;
  // text field state
  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool cantSeePassword = true;
  bool cantSeeConfirmPassword = true;
  String localeName = Platform.localeName.split('_')[0];
  bool _gkPos = false;
  bool _defPos = false;
  bool _mfPos = false;
  bool _forPos = false;

  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    this.user = await _userRepository.getUser();

    // if(user != null) {
    //   setState(() {
    //   });
    // }
  }

  Text _buildPageTitle() {
    return Text(
      'Completa tu perfil',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPositionsCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Posicion que jugas',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: ListTileTheme(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _gkPos = !_gkPos;
                });
              },
              child: ListTile(
                leading: Icon(Icons.add_to_queue),
                title: Center(
                  child: Text('Arquero'),
                ),
                trailing: Checkbox(
                  value: _gkPos,
                  onChanged: (val) {
                    setState(() {
                      _gkPos = !_gkPos;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: ListTileTheme(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _defPos = !_defPos;
                });
              },
              child: ListTile(
                leading: Icon(Icons.add_to_queue),
                title: Center(
                  child: Text('Defensor'),
                ),
                trailing: Checkbox(
                  value: _defPos,
                  onChanged: (val) {
                    setState(() {
                      _defPos = !_defPos;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: ListTileTheme(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _mfPos = !_mfPos;
                });
              },
              child: ListTile(
                leading: Icon(Icons.add_to_queue),
                title: Center(
                  child: Text('Mediocampista'),
                ),
                trailing: Checkbox(
                  value: _mfPos,
                  onChanged: (val) {
                    setState(() {
                      _mfPos = !_mfPos;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: ListTileTheme(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _forPos = !_forPos;
                });
              },
              child: ListTile(
                leading: Icon(Icons.add_to_queue),
                title: Center(
                  child: Text('Delantero'),
                ),
                trailing: Checkbox(
                  value: _forPos,
                  onChanged: (val) {
                    setState(() {
                      _forPos = !_forPos;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteProfileBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (!_gkPos && !_defPos && !_mfPos && !_forPos) {
            showAlert(
              context,
              'Completar perfil',
              'Debes seleccionar una posicion',
            );
          } else {
            // TODO enviar perfil completado y las posiciones
            BlocProvider.of<CompleteProfileBloc>(context).add(
                ProfileCompleteLoadingEvent()
            );

            await Future.delayed(Duration(seconds: 3));

            final Map res = await _userRepository.completeProfile(1);
            print('res');
            print(res);

            if (res.containsKey('success') && res['success'] == true) {
              Navigator.pushReplacementNamed(context, 'home');
              BlocProvider.of<CompleteProfileBloc>(context).add(
                  ProfileCompletedEvent()
              );
            } else {
              BlocProvider.of<CompleteProfileBloc>(context).add(
                  ProfileCompleteErrorEvent()
              );
              showAlert(
                context,
                'Complete profile error',
                'error',
              );
            }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Completar'.toUpperCase(),
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
                  builder: (BuildContext context, state) {
                    if (state is ProfileCompleteLoadingState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          whiteCircularLoading
                        ],
                      );
                    }

                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildPageTitle(),
                          SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildPositionsCheckboxes(),
                                SizedBox(height: 20.0),
                                _buildCompleteProfileBtn(),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
