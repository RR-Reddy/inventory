import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/pages/index.dart';
import 'package:inventory/providers/root_providers_widget.dart';
import 'package:inventory/service/nav_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RootProvidersWidget(
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Game Inventory',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: const SplashPage(),
          onGenerateRoute: generateRoute,
          navigatorKey: context.read<NavService>().navigatorKey,
        );
      }),
    );
  }
}

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  Widget pageWidget = const Scaffold();
  switch (routeSettings.name) {
    case SplashPage.routeName:
      pageWidget = const SplashPage();
      break;
    case SignInPage.routeName:
      pageWidget = const SignInPage();
      break;
    case HomePage.routeName:
      pageWidget = const HomePage();
      break;
    case AddEditInventoryPage.routeName:
      pageWidget = const AddEditInventoryPage();
      break;
  }

  return MaterialPageRoute(
    settings: routeSettings,
    builder: (_) => pageWidget,
  );
}
