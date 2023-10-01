import 'package:flutter/material.dart';
import 'package:inventory/extensions/index.dart';
import 'package:inventory/pages/add_edit_inventory/add_edit_inventory_provider.dart';
import 'package:inventory/pages/add_edit_inventory/widgets/index.dart';
import 'package:inventory/providers/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddEditInventoryPage extends StatelessWidget {
  const AddEditInventoryPage({Key? key}) : super(key: key);

  static const routeName = '/add-inventory';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddEditInventoryProvider(
        navProvider: context.read<NavProvider>(),
        authProvider: context.read<AuthProvider>(),
        homeProvider: context.read<HomeProvider>(),
      ),
      child: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              context.read<AddEditInventoryProvider>().close();
              return false;
            },
            child: GestureDetector(
              onTap: () => context.unfocus(),
              child: Scaffold(
                appBar: const AppbarWidget(),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        const NameInputWidget(),
                        SizedBox(height: 2.h),
                        const DescInputWidget(),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
