import 'package:flutter/material.dart';
import 'package:inventory/pages/add_edit_inventory/add_edit_inventory_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddEditInventoryProvider>();
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => provider.close(),
        icon: const Icon(Icons.close),
      ),
      title: const Text('Add Inventory'),
      actions: [
        const _SaveButtonWidget(),
        SizedBox(width: 4.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: FilledButton(
        onPressed: () => context.read<AddEditInventoryProvider>().saveInventory(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: const Text('Save'),
        ),
      ),
    );
  }
}