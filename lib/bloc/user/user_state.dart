part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool existUser;
  final User usuario;

  UserState({User user})
    : usuario = user ?? null,
    existUser = (user != null) ? true : false;


}

class UserInitial extends UserState {}
