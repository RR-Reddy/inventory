import 'package:flutter/material.dart';
import 'package:inventory/pages/splash/splash_provider.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => SplashProvider(
        navProvider: context.read<NavService>(),
        authProvider: context.read<AuthProvider>(),
        homeProvider: context.read<HomeProvider>(),
      ),
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
