import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get nav => navigatorKey.currentState!;
  BuildContext get context => navigatorKey.currentContext!;
}
