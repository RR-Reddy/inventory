import 'package:flutter/material.dart';
import 'package:inventory/models/index.dart';
import 'package:inventory/pages/index.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/extensions/index.dart';
import 'package:inventory/service/index.dart';
import 'package:inventory/utils/log_utils.dart';

class AddEditInventoryProvider extends ChangeNotifier {
  final NavProvider navProvider;
  final Inventory? inventory;
  final AuthProvider authProvider;
  final HomeProvider homeProvider;

  final DataService dataService = DataService();

  final nameCtrl = TextEditingController(text: '');
  final descCtrl = TextEditingController(text: '');

  AddEditInventoryProvider({
    required this.navProvider,
    required this.authProvider,
    required this.homeProvider,
    this.inventory,
  });

  void saveInventory() async {
    navProvider.context.unfocus();

    /// validate
    if (nameCtrl.text.isEmpty || descCtrl.text.isEmpty) {
      navProvider.context.showErrorMsg('Data should not be empty');
      return;
    }

    final completer =
        navProvider.navigatorKey.currentContext?.showLoadingDialog();
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
      navProvider.nav.popUntil(
          (Route<dynamic> route) => route.settings.name == HomePage.routeName);
    } catch (e, st) {
      LogUtils.logError('error', e, st);
      navProvider.context.showErrorMsg(e.toString());
    }
  }

  void deleteInventory() {}

  void close() async {
    if (descCtrl.text.isEmpty || nameCtrl.text.isEmpty) {
      navProvider.nav.pop();
      return;
    }

    final isSave = await navProvider.context.showAlertDialog(
      bodyText: 'Your changes have not been saved',
      pButtonText: 'Save',
      nButtonText: 'Discard',
    );

    if (isSave != true) {
      /// discard
      navProvider.nav.pop();
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
