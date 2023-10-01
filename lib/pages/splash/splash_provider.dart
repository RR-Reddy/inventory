import 'package:flutter/foundation.dart';
import 'package:inventory/pages/home/home_page.dart';
import 'package:inventory/pages/sign_in/sign_in_page.dart';
import 'package:inventory/providers/index.dart';

class SplashProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  final NavProvider navProvider;
  final HomeProvider homeProvider;

  SplashProvider({
    required this.navProvider,
    required this.authProvider,
    required this.homeProvider,
  }) {
    signInSilently();
  }

  void signInSilently() async {
    await authProvider.signInSilently();
    final routeName =
        authProvider.isSignedIn ? HomePage.routeName : SignInPage.routeName;
    if (authProvider.isSignedIn) {
      homeProvider.refreshData();
    }
    navProvider.nav.pushReplacementNamed(routeName);
  }
}
