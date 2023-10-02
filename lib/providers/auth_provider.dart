import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/pages/sign_in/sign_in_page.dart';
import 'package:inventory/service/index.dart';

///
/// Handles state of Google-sign
///
class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  final NavService navService;
  StreamSubscription? _authStateSub;

  bool get isSignedIn => user != null;

  User? get user => _user;
  User? _user;

  AuthProvider({
    required this.navService,
    required this.authService,
  }) {
    _authStateSub =
        authService.authStateChanges().listen(_listenAuthStateChanges);
  }

  void _listenAuthStateChanges(User? user)async {
    _user = user;
    if (user == null) {
      await Future.delayed(const Duration(seconds: 1));
      navService.nav.pushNamedAndRemoveUntil(
        SignInPage.routeName,
        (Route<dynamic> route) => false,
      );
    }
    notifyListeners();
  }

  Future<void> startSignFlow() async {
    _user = await authService.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    authService.signOut();
  }

  Future<void> signInSilently() async {
    await authService.signInSilently();
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSub?.cancel();
  }
}
