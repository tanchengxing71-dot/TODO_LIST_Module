import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:todo_list_module/common/router_page.dart';
import 'package:todo_list_module/const.dart';
import 'package:todo_list_module/native/api_channel.dart';
import 'package:todo_list_module/native/utils_channel.dart';
import 'package:todo_list_module/pages/complex_page.dart';
import 'package:todo_list_module/pages/todo/todo_list_page.dart';

class SimplePage extends TcxRouterPage {
  final String data;
  static String path = "/pages/simplePage";

  const SimplePage({super.key, required this.data});

  @override
  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {
    String data = arguments["data"] ?? "";

    return SimplePage(data: data);
  }

  @override
  TcxRouterPageState<TcxRouterPage> createState() => _SimplePage();
}

class _SimplePage extends TcxRouterPageState<SimplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Simple Page")),
          Center(child: Text(widget.data.toString())),
          Center(
            child: TextButton(
              onPressed: () {
                BoostNavigator.instance.push(
                  "${Const.origin}/main",
                  arguments: {"message": "来自Flutter层的SimplePage"},
                );
              },
              child: Text("跳转原生Main"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                BoostNavigator.instance.push(
                  Const.origin + ComplexPage.path,
                  arguments: {"data": "来自Flutter层的SimplePage"},
                );
              },
              child: Text("跳转complexPage"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                BoostNavigator.instance.pop({
                  "message": "来自Flutter层的SimplePage",
                });
              },
              child: Text("返回原生Main"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                UtilsChannel.showToast("hello Android");
              },
              child: Text("测试原生通道"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                ApiChannel.testRequest();
              },
              child: Text("测试原生网络请求"),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                BoostNavigator.instance.push(
                  Const.origin + TodoListPage.path,
                );
              },
              child: Text("跳转TodoList页面"),
            ),
          ),
        ],
      ),
    );
  }
}
