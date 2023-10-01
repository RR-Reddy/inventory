import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  StreamSubscription? _subscription;

  var _isConnected = true;

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _listenUpdates();
  }

  void _listenUpdates() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _updateConnectedStatus(result != ConnectivityResult.none);
    });
  }

  void _updateConnectedStatus(bool isConnected) {
    if (this.isConnected != isConnected) {
      _isConnected = isConnected;
      notifyListeners();
    }
  }

  @override
  dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}