import 'package:flutter/material.dart';
import 'package:inventory/models/inventory.dart';
import 'package:inventory/pages/index.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/extensions/index.dart';
import 'package:inventory/service/index.dart';
import 'package:inventory/utils/log_utils.dart';

class AddEditInventoryProvider extends ChangeNotifier {
  final NavService navService;
  final AuthProvider authProvider;
  final HomeProvider homeProvider;

  final DataService dataService;

  final nameCtrl = TextEditingController(text: '');
  final descCtrl = TextEditingController(text: '');

  AddEditInventoryProvider({
    required this.navService,
    required this.authProvider,
    required this.homeProvider,
    required this.dataService,
  });

  void saveInventory() async {
    navService.context.unfocus();

    /// validate
    if (nameCtrl.text.isEmpty || descCtrl.text.isEmpty) {
      navService.context.showErrorMsg('Data should not be empty');
      return;
    }

    final completer =
        navService.navigatorKey.currentContext?.showLoadingDialog();
    try {
      final model = Inventory(
        name: nameCtrl.text,
        desc: descCtrl.text,
        userId: authProvider.user?.uid ?? '',
        status: 'new',
        id: '',
      );
      dataService.addInventory(model);

      homeProvider.refreshData();
      completer?.complete(Future.value(true));
      await Future.delayed(Duration.zero);
      navService.nav.popUntil(
          (Route<dynamic> route) => route.settings.name == HomePage.routeName);
    } catch (e, st) {
      LogUtils.logError('error', e, st);
      navService.context.showErrorMsg(e.toString());
    }
  }

  void deleteInventory() {}

  void close() async {
    if (descCtrl.text.isEmpty || nameCtrl.text.isEmpty) {
      navService.nav.pop();
      return;
    }

    final isSave = await navService.context.showAlertDialog(
      bodyText: 'Your changes have not been saved',
      pButtonText: 'Save',
      nButtonText: 'Discard',
    );

    if (isSave != true) {
      /// discard
      navService.nav.pop();
      return;
    }
    saveInventory();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}
