import 'package:flutter/material.dart';
import 'package:inventory/extensions/index.dart';
import 'package:inventory/pages/home/widgets/index.dart';
import 'package:inventory/pages/index.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex =
        context.select<HomeProvider, int>((p) => p.selectedTabIndex);

    return GestureDetector(
      onTap: () => context.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const SearchInputWidget()),
        drawer: const DrawerWidget(),
        bottomNavigationBar: const BottomNavWidget(),
        body: selectedTabIndex == 0
            ? const InventoryBodyWidget()
            : const BuyBodyWidget(),
        floatingActionButton: selectedTabIndex == 0
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => context
                    .read<NavProvider>()
                    .nav
                    .pushNamed(AddEditInventoryPage.routeName),
              )
            : null,
      ),
    );
  }
}
