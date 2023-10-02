import 'package:flutter/material.dart';

///
/// [NavService] is just a wrapper for navigation and [BuildContext].
///
class NavService {
  late final GlobalKey<NavigatorState> navigatorKey;

  NavService({GlobalKey<NavigatorState>? navigatorKey}) {
    this.navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
  }

  NavigatorState get nav => navigatorKey.currentState!;

  BuildContext get context => navigatorKey.currentContext!;
}
