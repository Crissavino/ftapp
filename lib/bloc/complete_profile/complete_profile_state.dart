part of 'complete_profile_bloc.dart';

@immutable
abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}

class ProfileCompleteLoadingState extends CompleteProfileState {}

class ProfileCompletedState extends CompleteProfileState {}

class ProfileCompleteErrorState extends CompleteProfileState {}