import 'package:flutter/material.dart';

class NavService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get nav => navigatorKey.currentState!;

  BuildContext get context => navigatorKey.currentContext!;
}
