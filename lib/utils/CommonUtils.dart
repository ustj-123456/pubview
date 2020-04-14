
import 'dart:async';
import 'package:cyoga/res/style.dart';
import 'package:cyoga/widget/FlexButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'NavigatorUtils.dart';

/**
 * 通用工具类
 */
class CommonUtils {

  ///列表item dialog
  static Future<Null> showCommitOptionDialog(
      BuildContext context,
      List<String> commitMaps,
      ValueChanged<int> onTap, {
        width = 300.0,
        height = 400.0,
      }) {
    return NavigatorUtils.showCyogaDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: CyogaColors.white,
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return CyogaFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: Theme.of(context).primaryColor,
                      text: commitMaps[index],
                      textColor: CyogaColors.black_3,
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }



  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showCyogaDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            child:
                            SpinKitCubeGrid(color: CyogaColors.white)),
                        new Container(height: 10.0),
                        new Container(
                            child: new Text(
                                "正在处理中...",
                                style: CyogaConstant.normalTextWhite)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  /**
   * AlertDialog
   */
  static Future<Null> showAlertDialog(
      BuildContext context, String contentMsg) {
    return NavigatorUtils.showCyogaDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("v3"),
            content: new Text(contentMsg),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("取消")),
              new FlatButton(
                  onPressed: () {

                    Navigator.pop(context);
                  },
                  child: new Text("确定")),
            ],
          );
        });
  }
}
