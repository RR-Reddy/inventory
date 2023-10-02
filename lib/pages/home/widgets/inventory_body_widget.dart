import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InventoryBodyWidget extends StatelessWidget {
  const InventoryBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    if (homeProvider.inventoryList.isEmpty) {
      return const Center(child: Text("Please add new Inventory item "));
    }

    if (homeProvider.inventoryFilteredList.isEmpty) {
      return const Center(child: Text("Sorry don't have any matched records"));
    }

    return ListView.separated(
      itemBuilder: (_, index) => _InventoryTileWidget(
          inventory: homeProvider.inventoryFilteredList[index]),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: homeProvider.inventoryFilteredList.length,
    );
  }
}

class _InventoryTileWidget extends StatelessWidget {
  const _InventoryTileWidget({Key? key, required this.inventory})
      : super(key: key);
  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
      title: Text(inventory.name),
      subtitle: Text(inventory.desc),
      trailing: IconButton(
        onPressed: () =>
            context.read<HomeProvider>().deleteInventory(inventory),
        icon: Icon(Icons.delete, size: 12.w),
      ),
    );
  }
}
