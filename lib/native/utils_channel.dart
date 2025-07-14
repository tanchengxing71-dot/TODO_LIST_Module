import 'package:flutter/services.dart';

class UtilsChannel {
  static final MethodChannel _channel = const MethodChannel("Tcx.utils");


  static Future<void> showToast(String msg) {
    return _channel.invokeMethod("show_toast", {'msg': msg});
  }
}