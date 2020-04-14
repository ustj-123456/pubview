import 'dart:async';

import 'package:cyoga/dao/user_dao.dart';
import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/widget/common/arc_bg.dart';
import 'package:cyoga/widget/common/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Registered extends StatefulWidget {
  @override
  _RegisteredState createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _code = TextEditingController();
  TextEditingController _repeatpassword = TextEditingController();
  Timer _timer;
  int _countdownTime = 0;
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }

  checkmobile() {
    String phone = _phoneNum.text;
    var res =  new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(phone);
    if(!res) {
      Fluttertoast.showToast(
          msg: "请输入正确的手机号码",
          gravity: ToastGravity.CENTER
      );
      _phoneNum.clear();
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: ThemeColor.appBg,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ArcBackground(Screen.width(), AppSize.height(800)),
                Container(
                  margin: EdgeInsets.only(
                      top: AppSize.height(300),
                      left: AppSize.width(30),
                      right: AppSize.width(30),
                      bottom: AppSize.height(120)),
                  padding: EdgeInsets.only(
                      top: AppSize.height(300),
                      right: AppSize.width(60),
                      left: AppSize.width(60)),
                  decoration: ThemeDecoration.card,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNum,
                        maxLines: 1,
                        maxLength: 11,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_iphone),
                            hintText: "请输入手机号",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                      ),
                      TextField(
                        controller: _code,
                        maxLines: 1,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.supervisor_account),
                            hintText: "请输入短信验证码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30)),
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSize.height(30)),
                              child: GestureDetector(
                                onTap: () {
                                  if (_countdownTime == 0 && checkmobile()) {
                                      //Http请求发送验证
                                      UserDao.sendCode(_phoneNum.text);
                                      setState(() {
                                        _countdownTime = 60;
                                      });
                                    //开始倒计时
                                    startCountdownTimer();
                                  }
                                },
                                child: Text(
                                  _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _countdownTime > 0
                                        ? Color.fromARGB(255, 183, 184, 195)
                                        : Color.fromARGB(255, 17, 132, 255),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      TextField(
                        controller: _password,
                        maxLines: 1,
                        maxLength: 20,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "请输入登录密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                      ),
                      TextField(
                        controller: _repeatpassword,
                        maxLines: 1,
                        maxLength: 20,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "请再次确认登录密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30))),
                      ),
                      InkWell(
                        child: Container(
                          width: Screen.width(),
                          margin: EdgeInsets.symmetric(
                              vertical: AppSize.height(30)),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.height(20)),
                          child: Center(
                              child: Text('注册', style: TextStyle(
                                fontSize: AppSize.sp(45), color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ThemeColor.appBarTopBg,
                                ThemeColor.appBarBottomBg
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onTap: (){
                          String phone = _phoneNum.text;
                          String password = _password.text;
                          String code = _code.text;
                          String repeatpassword = _repeatpassword.text;
                          if(phone.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "请输入正确手机号码",
                                gravity: ToastGravity.CENTER
                            );
                            return;
                          }
                          if(code.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "请输入验证码",
                                gravity: ToastGravity.CENTER
                            );
                            return;
                          }
                          if(password.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "请输入登录密码",
                                gravity: ToastGravity.CENTER
                            );
                            return;
                          }
                          if(password != repeatpassword) {
                            Fluttertoast.showToast(
                                msg: "两次输入密码不一致",
                                gravity: ToastGravity.CENTER
                            );
                            return;
                          }
                          UserDao.register(code, phone, password).then((res){
                            if(res["errno"]==0) {
                              Fluttertoast.showToast(
                                  msg: "用户注册成功，请重新登录",
                                  gravity: ToastGravity.CENTER
                              ).then((val){
                                Provider.of<UserProviderModel>(context).set(new UserModel());
                                Routes.instance.navigateReplaceTo(context, Routes.LOGIN_PAGE);
                              });
                            }else {
                              Fluttertoast.showToast(
                                  msg: res["errmsg"],
                                  gravity: ToastGravity.CENTER
                              );
                            }
                          });
                        }
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppSize.height(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('已有账号，', style: ThemeTextStyle.cardNumStyle),
                            GestureDetector(
                              onTap: (){
                                Routes.instance.navigateReplaceTo(context, Routes.LOGIN_PAGE);
                              },
                              child:  Text(
                                '立即登录',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: AppSize.sp(36),
                                    color: Color(0xFF02A9FF)),
                              ),
                            )
                           ,
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Checkbox(
                              value: true,
                              onChanged: (v) {},
                            ),
                          ),
                          Text('我已阅读并同意遵守',
                              style: TextStyle(
                                  fontSize: AppSize.sp(30),
                                  color: ThemeColor.subTextColor)),
                          Text('《服务许可协议》',
                              style: TextStyle(
                                  fontSize: AppSize.sp(30),
                                  decoration: TextDecoration.underline,
                                  color: ThemeColor.hintTextColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: Screen.width(),
                  top: AppSize.height(260),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AvatarView(
                        imgPath: 'images/logo.png',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: Screen.statusH() + AppSize.height(30),
                  left: AppSize.width(30),
                  child: InkWell(
                      onTap: () {
                        Routes.instance.navigateReplaceTo(context, Routes.ROOT ,"0");
                      },
                      child: Icon(
                        YogaIcons.home,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
