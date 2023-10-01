import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex =
        context.select<HomeProvider, int>((p) => p.selectedTabIndex);
    return NavigationBar(
      selectedIndex: selectedTabIndex,
      onDestinationSelected: (int index) =>
          context.read<HomeProvider>().updateTabIndex(index),
      destinations: const [
        NavigationDestination(
          label: 'Inventory',
          icon: Icon(Icons.inventory_outlined),
          selectedIcon: Icon(Icons.inventory),
          tooltip: 'Inventory',
        ),
        NavigationDestination(
          label: 'Buy',
          icon: Icon(Icons.business_outlined),
          selectedIcon: Icon(Icons.business),
          tooltip: 'Buy inventory',
        ),
      ],
    );
  }
}
