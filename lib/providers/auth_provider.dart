import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/pages/sign_in/sign_in_page.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _service = AuthService();
  final NavProvider navProvider;
  StreamSubscription? _authStateSub;

  bool get isSignedIn => user != null;

  User? get user => _user;
  User? _user;

  AuthProvider({required this.navProvider}) {
    _authStateSub = _service.authStateChanges().listen(_listenAuthStateChanges);
  }

  void _listenAuthStateChanges(User? user) {

    print('user update : $user');

    _user = user;
    if (user == null) {
      navProvider.nav.pushNamedAndRemoveUntil(
        SignInPage.routeName,
        (Route<dynamic> route) => false,
      );
    }
    notifyListeners();
  }

  Future<void> startSignFlow() async {
    _user = await _service.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    _service.signOut();
  }

  Future<void> signInSilently() async {
    await _service.signInSilently();
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSub?.cancel();
  }
}
