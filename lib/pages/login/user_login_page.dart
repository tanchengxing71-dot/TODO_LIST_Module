import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tcx_base_module/common/router_page.dart';

class UserLoginPage extends TcxRouterPage {
  const UserLoginPage({super.key});

  @override
  TcxRouterPage? routerPageBuild(Map<String, dynamic> arguments) {
    return UserLoginPage();
  }

  @override
  TcxRouterPageState<TcxRouterPage> createState() => _UserLoginPage();

}

class _UserLoginPage extends TcxRouterPageState<UserLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}