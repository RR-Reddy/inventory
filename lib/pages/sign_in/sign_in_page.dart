import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:inventory/pages/sign_in/sign_in_provider.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SignInProvider(
              authProvider: context.read<AuthProvider>(),
              navProvider: context.read<NavService>(),
              homeProvider: context.read<HomeProvider>(),
          ),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Text(
                  'Game Inventory System',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                const Spacer(flex: 2),
                Builder(
                  builder: (context) {
                    final provider = context.watch<SignInProvider>();

                    return provider.isLoading
                        ? const CircularProgressIndicator()
                        : SignInButton(
                      Buttons.Google,
                      onPressed: () => provider.startSignFlow(),
                    );
                  },
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
