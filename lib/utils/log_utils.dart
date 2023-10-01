import 'dart:developer';

import 'package:flutter/foundation.dart';

class LogUtils{
  static void logMsg(Object obj, dynamic msg) {
    if (kReleaseMode) {
      return;
    }

    var className = obj.runtimeType.toString();
    className = className == 'String' ? obj as String : className;

    var consoleOut = '$className msg : $msg';
    log(consoleOut);
    // print(consoleOut);
  }

  static void logError(Object obj, dynamic msg, [StackTrace? st]) {
    var str = 'Error : ${msg?.toString()} stack trace : $st';
    if (kReleaseMode) {
      return;
    } else {
      logMsg(obj, str);
    }
  }
}