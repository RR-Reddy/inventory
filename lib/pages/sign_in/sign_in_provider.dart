import 'package:flutter/foundation.dart';
import 'package:inventory/pages/home/home_page.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';
import 'package:inventory/utils/log_utils.dart';

class SignInProvider extends ChangeNotifier {
  final AuthProvider authProvider;
  final NavService navProvider;
  final HomeProvider homeProvider;

  bool get isLoading => _isLoading;
  var _isLoading = false;

  SignInProvider({
    required this.authProvider,
    required this.navProvider,
    required this.homeProvider,
  });

  void startSignFlow() async {
    _isLoading = true;
    notifyListeners();
    try {
      await authProvider.startSignFlow();
    } catch (e, st) {
      LogUtils.logError(this, e, st);
    }

    _isLoading = false;
    notifyListeners();

    if (authProvider.isSignedIn) {
      homeProvider.refreshData();
      navProvider.nav.pushReplacementNamed(HomePage.routeName);
    }
  }
}
