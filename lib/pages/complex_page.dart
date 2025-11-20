import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:tcx_base_module/common/router_page.dart';
import 'package:tcx_base_module/const.dart';
import 'package:tcx_base_module/pages/simple_page.dart';

import '../native/api_channel.dart';
import '../native/utils_channel.dart';

class ComplexPage extends TcxRouterPage {
  final String data;
  static String path = "/pages/complexPage";

  const ComplexPage({super.key, required this.data});

  @override
  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {

    String data = arguments["data"] ?? "";

    return ComplexPage(
      data: data,
    );
  }



  @override
  TcxRouterPageState<TcxRouterPage> createState() => _ComplexPage();
}

class _ComplexPage extends TcxRouterPageState<ComplexPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Complex Page"),
          ),
          Center(
            child: Text(widget.data.toString()),
          ),
          Center(
            child: TextButton(onPressed: () {
              BoostNavigator.instance.push(
                  "${Const.origin}/main", arguments: {"message": "来自Flutter层的ComplexPage"});
            }, child: Text("跳转原生Main")),
          ),
          Center(
            child: TextButton(onPressed: () {
              BoostNavigator.instance.push(Const.origin+SimplePage.path,arguments: {"data":"来自Flutter层的ComplexPage"});
            }, child: Text("跳转simplePage")),
          ),
          Center(
            child: TextButton(onPressed: () {
              BoostNavigator.instance.pop(
                  {"message": "来自Flutter层的ComplexPage"});
            }, child: Text("返回原生Main")),
          ),
          Center(
            child: TextButton(onPressed: () {
              UtilsChannel.showToast("hello Android");
            }, child: Text("测试原生通道")),
          ),
          Center(
            child: TextButton(onPressed: () {
              ApiChannel.testRequest();
            }, child: Text("测试原生网络请求")),
          ),

        ],
      ),
    );
  }

}