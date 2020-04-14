import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * 加载动画
 * Created by yangdecheng
 * Date: 2019-11-04
 * https://github.com/jogboms/flutter_spinkit
 */
class CyogaLoadingPage {
  final BuildContext _context;

  CyogaLoadingPage(this._context);

  ///打开loading
  void show({Function onClosed}) {
    showDialog(
      context: _context,
      builder: (context) {
        return SpinKitWanderingCubes(color: Colors.white);
      },
    ).then((value) {
      //onClosed(value);
    });
  }

  ///关闭loading
  void close() {
    Navigator.of(_context).pop();
  }
}
