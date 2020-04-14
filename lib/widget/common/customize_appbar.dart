import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:cyoga/utils/constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  @override
  final Size preferredSize;

  const MyAppBar({
    Key key,
    @required this.child,
    @required this.preferredSize,
  }) : super(key: key);

  void initStateBar() async{
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = Screen.statusH();

    return Container(
      padding: EdgeInsets.only(left: 6, right: 6,top: _statusHeight),
      decoration: BoxDecoration(),
      height: preferredSize.height+_statusHeight,
//        color: Theme.of(context).primaryColor,
      child: this.child,
    );
  }
}
