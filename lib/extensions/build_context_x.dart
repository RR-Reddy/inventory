import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory/providers/index.dart';
import 'package:inventory/service/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

extension BuildContextX on BuildContext {
  bool get isConnected => read<ConnectivityProvider>().isConnected;

  bool get isNotConnected => !isConnected;

  EdgeInsets get scrollPadding =>
      EdgeInsets.only(bottom: MediaQuery.of(this).viewInsets.bottom + 8.h);

  void unfocus() => FocusScope.of(this).unfocus();

  void showErrorMsg(String msg) {
    ScaffoldMessenger.of(read<NavService>().navigatorKey.currentContext!)
        .showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void showNoInternetDialog() {
    showAlertDialog(
      title: 'Network Error!',
      bodyText:
          'Could be a network error. Please check your Data or WIFI connection and try again!',
      isSingleAction: true,
      pButtonText: 'OK',
    );
  }

  Future<bool?> showAlertDialog({
    bool isSingleAction = false,
    String title = '',
    String bodyText = 'body text',
    String pButtonText = 'YES',
    String nButtonText = 'NO',
    Function? pButtonBlock,
    Function? nButtonBlock,
    bool barrierDismissible = false,
  }) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(nButtonText),
      onPressed: () {
        Navigator.of(this).pop(false);
        if (nButtonBlock != null) {
          nButtonBlock();
        }
      },
    );
    Widget continueButton = TextButton(
      child: Text(pButtonText),
      onPressed: () {
        Navigator.of(this).pop(true);
        if (pButtonBlock != null) {
          pButtonBlock();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: title.isEmpty ? null : Text(title),
      content: WillPopScope(
        child: Text(bodyText),
        onWillPop: () async => barrierDismissible,
      ),
      actions:
          isSingleAction ? [continueButton] : [cancelButton, continueButton],
    );

    // show the dialog
    return await showDialog<bool?>(
      barrierDismissible: barrierDismissible,
      context: this,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Completer showLoadingDialog({String msg = 'Loading'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: WillPopScope(
            onWillPop: () async => false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(msg),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    final completer = Completer();
    completer.future.then((value) => read<NavService>().nav.pop());
    return completer;
  }
}
