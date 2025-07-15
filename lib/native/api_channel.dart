import 'package:flutter/services.dart';

class ApiChannel {
  static final MethodChannel _channel = const MethodChannel("Tcx.api");


  static Future<void> testRequest() {
    return _channel.invokeMethod("test_request", {'key': "cdcb2c50681295801be24a00498ecb2c",'type': "xijia"});
  }
}