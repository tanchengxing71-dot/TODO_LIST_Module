import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:tcx_video_call_module/common/router_page.dart';
import 'package:tcx_video_call_module/const.dart';
import 'package:tcx_video_call_module/pages/complex_page.dart';

class SimplePage extends TcxRouterPage {
  final String data;
  static String path = "/pages/simplePage";

  const SimplePage({super.key, required this.data});

  @override
  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {
    String data = arguments["data"] ?? "";

    return SimplePage(
      data: data,
    );
  }

  @override
  TcxRouterPageState<TcxRouterPage> createState() => _SimplePage();


}

class _SimplePage extends TcxRouterPageState<SimplePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Simple Page"),
          ),
          Center(
            child: Text(widget.data.toString()),
          ),
          Center(
            child: TextButton(onPressed: () {
              BoostNavigator.instance.push(
                  "${Const.origin}/main", arguments: {"data": "来自Flutter层的SimplePage"});
            }, child: Text("跳转原生Main")),
          ),
          Center(
            child: TextButton(onPressed: () {
              BoostNavigator.instance.push(Const.origin+ComplexPage.path,arguments: {"data":"来自Flutter层的SimplePage"});
            }, child: Text("跳转complexPage")),
          )
        ],
      ),
    );
  }

}