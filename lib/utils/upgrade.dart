import 'dart:convert';
import 'dart:io';
import 'package:cyoga/dao/user_dao.dart';
import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/utils/http_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dbutil.dart';

// app 升级
class Upgrade {
  //定义apk的名称，与下载进度dialog
  String apkName ='cyoga.apk';
  ProgressDialog pr;
  String downUrl = "/downpks/version.json";

  // 检查是否存在更新
  Future<void> checkUpdate(BuildContext context) async{
    // 获取用户信息
    String token = await SharedPreferenceUtil.query("token") ?? "";
    String user = await SharedPreferenceUtil.query("user") ?? "";
    var userModel = new UserModel();
    if(token.isNotEmpty) {
        userModel = UserModel.fromJson(json.decode(user));
        userModel.token = token;
    }
    Provider.of<UserProviderModel>(context).set(userModel);
    //Android , 需要下载apk包
    return;
    if(Platform.isAndroid){
      print('is android');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String localVersion = packageInfo.version;

      //获取服务端中最新的app版本信息
      print(downUrl);
      var http = await HttpUtilDownApk.getInstance();
      var versionInfo = await http.get(downUrl);
      if(versionInfo != null){
        Map<String, dynamic> map = versionInfo;
        String serverAndroidVersion = map['android_version'].toString();
        String serverMsg = map['android_msg'].toString();
        String url = map['android_url'].toString();
        print(url);
        print('本地版本: ' + localVersion + ',最新版本: ' + serverAndroidVersion );
        int c = serverAndroidVersion.compareTo(localVersion);
        //如果服务端版本大于本地版本则提示更新
        if(c == 1){
          showUpdate(context, serverAndroidVersion, serverMsg, url);
        }
      }
    }
    //Ios , 只能跳转到 AppStore , 直接采用url_launcher就可以了
    //android也可以采用此方法，会跳转到手机浏览器中下载
    if(Platform.isIOS){
      print('is ios');
      final url = "https://itunes.apple.com/cn/app/id1380512641"; // id 后面的数字换成自己的应用 id 就行了
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  ///2.显示更新内容
  Future<void> showUpdate(BuildContext context , String version, String data, String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('检测到新版本 v$version'),
          content : Text('是否要更新到最新版本?') ,
          actions: <Widget>[
            FlatButton(
              child: Text('下次在说'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('立即更新'),
              onPressed: ()=>doUpdate(context,version,url)
              ,
            ),
          ],
        );
      },
    );
  }

  ///3.执行更新操作
  doUpdate(BuildContext context , String version,String url) async {
    //关闭更新内容提示框
    Navigator.pop(context);
    //获取权限
    var per = await checkPermission();
    if(per != null && !per){
      return null;
    }
    //开始下载apk
    executeDownload(context , url);
  }

  ///4.检查是否有权限
  Future<bool> checkPermission() async {
    //检查是否已有读写内存权限
    PermissionStatus permission  = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    print(permission );

    //判断如果还没拥有读写权限就申请获取权限
    if(permission  != PermissionStatus.granted){
      var map = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      if(map[PermissionGroup.storage] != PermissionStatus.granted){
        return false;
      }
    }
    return true;
  }

  ///5.下载apk
  Future<void> executeDownload(BuildContext context ,String url) async {
    //下载时显示下载进度dialog
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style();
    if (!pr.isShowing()) {
      pr.show();
    }
    //apk存放路径
    final path = await _apkLocalPath;
    File file = File(path + '/' + apkName);
    if (await file.exists()) await file.delete();

    try {
      OtaUpdate().execute(url,destinationFilename:"cyoga.apk").listen(
            (OtaEvent event) {
          print('status:${event.status},value:${event.value}');
          switch(event.status){
            case OtaStatus.DOWNLOADING: // 下载中
              int rate = int.parse('${event.value}');
              pr.update( message: "努力升级中，已完成 "+ rate.toString() +"%" );
              break;
            case OtaStatus.INSTALLING: //安装中
              _installApk();
              break;
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
              print('更新失败，请稍后再试');
              break;
            default: // 其他问题
              break;
          }
          if(event.status!= OtaStatus.DOWNLOADING) {
            if (pr.isShowing()) {
              pr.hide();
            }
          }
        },
      );
    } catch (e) {
      print('更新失败，请稍后再试');
    }
  }

  //6.安装app
  Future<Null> _installApk() async {
    String path = await _apkLocalPath;
    await OpenFile.open(path + '/' + apkName);
  }
  // 获取apk存放地址(外部路径)
  Future<String> get _apkLocalPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }
}
