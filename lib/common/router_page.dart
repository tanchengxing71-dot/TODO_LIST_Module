
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';


typedef TcxRouterPageRegister = Map<String, TcxRouterPage> Function();

abstract class TcxRouterPage extends StatefulWidget {
  const TcxRouterPage({
    super.key,
    this.changeStatusBar = true,
    this.statusBarColor = Colors.transparent,
    this.statusBarDark = true,
  });
  final Color statusBarColor;
  final bool changeStatusBar;
  final bool statusBarDark;

  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {
    return null;
  }

  TcxRouterPage? uniqueRouterPageBuild(Map<String, dynamic> arguments, String? uniqueId) {
    return routerPageBuild(arguments);
  }

  bool needLogin() {
    return false;
  }

  String routerPageTitle() {
    return "";
  }

  @override
  TcxRouterPageState createState();
}

abstract class TcxRouterPageState<T extends TcxRouterPage> extends State<T>
    with PageVisibilityObserver {


  @override
  @mustCallSuper
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 或你想要的颜色
      statusBarIconBrightness: Brightness.dark, // 黑色字体
    ));

  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///注册监听器
    var route = ModalRoute.of(context);
    if (route != null) {
      PageVisibilityBinding.instance.addObserver(this, route);
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    ///移除监听器
    PageVisibilityBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  @mustCallSuper
  void onPageShow() async {
    super.onPageShow();

  }

  @override
  @mustCallSuper
  void onPageHide() {

  }
}
