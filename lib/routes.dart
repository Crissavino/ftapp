import 'package:app/ui/auth/login_screen.dart';
import 'package:app/ui/auth/register_screen.dart';
import 'package:app/ui/chats/chats_screen.dart';
import 'package:app/ui/matches/matches_screen.dart';
import 'package:app/ui/play_now/play_now_screen.dart';
import 'package:app/ui/profiles/complete_profile_screen.dart';
import 'package:app/ui/profiles/profile_screen.dart';
import 'package:app/ui/profiles/public_profile_screen.dart';

final routes = {
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'complete_profile': (_) => CompleteProfileScreen(),
  // bottom menu
  'profile': (_) => ProfileScreen(),
  'matches': (_) => MatchesScreen(),
  'play_now': (_) => PlayNowScreen(),
  'chats': (_) => ChatsScreen(),
  // other routes
  'public_profile': (_) => PublicProfile(),
};