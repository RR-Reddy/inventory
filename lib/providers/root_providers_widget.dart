import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';
import 'package:provider/provider.dart';

class RootProvidersWidget extends StatelessWidget {
  const RootProvidersWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => NavService()),
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => DataService()),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            navService: context.read<NavService>(),
            authService: context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
            authProvider: context.read<AuthProvider>(),
            dataService: context.read<DataService>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
