import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/page/base/com_scaffold.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/dbutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Widget> contentList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return ComScaffold(
      title: "设置",
      titleId: "",
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20,right: 20),
        child: RaisedButton(
          child: Text("退出登录"),
          color: Colors.red,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),onPressed: () {
            SharedPreferenceUtil.delete("token");
            SharedPreferenceUtil.delete("user");
            SharedPreferenceUtil.delete("userId");
            Fluttertoast.showToast(msg:"退出成功").then((val){
              Routes.instance.navigateReplaceTo(context, Routes.ROOT, "0");
            });
          },
        ),
      ),
    );
    ;
  }
}
