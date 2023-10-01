import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';

class RootProvidersWidget extends StatelessWidget {
  const RootProvidersWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            navProvider: context.read<NavProvider>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(
            authProvider: context.read<AuthProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
