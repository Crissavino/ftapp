import 'package:app/ui/auth/login_screen.dart';
import 'package:app/ui/auth/register_screen.dart';
import 'package:app/ui/profiles/complete_profile_screen.dart';
import 'package:app/ui/profiles/profile_screen.dart';
import 'package:app/ui/profiles/public_profile_screen.dart';
import 'package:app/ui/widgets/main_container.dart';

final routes = {
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'home': (_) => MainContainer(),
  'complete_profile': (_) => CompleteProfileScreen(),
  'public_profile': (_) => PublicProfile(),
  'profile': (_) => ProfileScreen(),
};