import 'package:cyoga/page/base/web_scaffold.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:flutter/material.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCartPageState createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {

  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new WebScaffold("",
      title: "购物车",
      url: Web_Links["26"][3],
    );
  }
}
