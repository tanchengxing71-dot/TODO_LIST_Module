import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:tcx_video_call_module/common/router_page.dart';
import 'package:tcx_video_call_module/const.dart';
import 'package:tcx_video_call_module/pages/complex_page.dart';
import 'package:tcx_video_call_module/pages/simple_page.dart';


class TcxRouter{

  static Map<String, dynamic> routerMapList = {
    Const.origin+ComplexPage.path: ComplexPage(data: "",),
    Const.origin+SimplePage.path: SimplePage(data: "",),
  };


  static FlutterBoostRouteFactory register(){
    Map<String,FlutterBoostRouteFactory> routerMap={};
    routerMapList.forEach(
        (key,value){
          routerMap[key]=(RouteSettings settings, String? uniqueId){
            return PageRouteBuilder<dynamic>(
                settings: settings,
                pageBuilder: (BuildContext context, __, ___) {
                  var data = MediaQuery.of(context);
                  if (value is TcxRouterPage) {
                    var json = jsonDecode(jsonEncode(settings.arguments));
                    var map = Map<String, dynamic>.from(json);
                    var page = value.uniqueRouterPageBuild(map, uniqueId);
                    if (page != null) {
                      value = page;
                    }
                  }
                  return MediaQuery(
                    data: data.copyWith(textScaler: TextScaler.linear(1)),
                    child: value,
                  );
                });
          };
        }
    );

    return (RouteSettings settings, String? uniqueId){
      final func = routerMap[settings.name];
      if (func != null) {
        return func(settings, uniqueId);
      }
      return null;
    };

  }
}