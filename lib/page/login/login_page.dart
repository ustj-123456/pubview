import 'package:cyoga/common/libs.dart';
import 'package:cyoga/dao/user_dao.dart';
import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/utils/dbutil.dart';
import 'package:cyoga/widget/common/arc_bg.dart';
import 'package:cyoga/widget/common/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNum = TextEditingController();
  TextEditingController _password = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: ThemeColor.appBg,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSize.height(30), bottom: AppSize.height(60)),
                      child: TextField(
                        controller: _password,
                        maxLines: 1,
                        maxLength: 20,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "请输入登录密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppSize.height(30)),
                            suffixIcon: Icon(
                              YogaIcons.home,
                              size: AppSize.width(50),
                            )),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            child:Text(
                              '忘记密码?',
                              style: ThemeTextStyle.menuStyle3,
                            ) ,
                            onTap: (){
                              Routes.instance.navigateTo(context, Web_Links["15"][2], "15");
                            }
                          )
                        ]),
                    InkWell(
                      child: Container(
                        width: Screen.width(),
                        margin: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                        padding: EdgeInsets.symmetric(vertical: AppSize.height(20)),
                        child: Center(
                            child: Text('登录', style: TextStyle(
                              fontSize: AppSize.sp(45), color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ThemeColor.appBarTopBg,
                              ThemeColor.appBarBottomBg
                            ]),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      onTap: (){
                        var userName = _phoneNum.text.toString();
                        var userPwd = _password.text;
                        if(userName.toString().length <11) {
                          Fluttertoast.showToast(
                              msg: "请输入正确的手机号",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos:1
                          );
                          return;
                        }
                        if(userPwd=='') {
                          Fluttertoast.showToast(
                              msg: "请输入密码",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos:1
                          );
                          return;
                        }
                        UserDao.login(userName, userPwd).then((res){
                          var errno = res["errno"];
                          if(errno!= 0) {
                            Fluttertoast.showToast(
                                msg: "用户名或者密码不正确",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos:1
                            );
                            return;
                          }
                          Fluttertoast.showToast(
                              msg: "登录成功",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos:1
                          ).then((value){
                            var data = res["data"];
                            var userInfo = data["userInfo"];
                            var userModel = UserModel.fromJson(userInfo);
                            String user = json.encode(userModel);
                            SharedPreferenceUtil.put("token", data["token"]);
                            SharedPreferenceUtil.put("user", user);
                            SharedPreferenceUtil.put("userId", userModel.username);
                            Provider.of<UserProviderModel>(context).set(userModel);
                            Routes.instance.navigateReplaceTo(context, Routes.ROOT, "4");
                          });
                        });
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSize.height(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('验证码登录',style: ThemeTextStyle.menuStyle3),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppSize.width(30)),
                            child: SizedBox(
                              height: AppSize.height(30),
                                child: ThemeView.divider(orient: Orient.vertical)),
                          ),

                          InkWell(
                            onTap: (){
                              Routes.instance.navigateFromBottom(context, Routes.registered_page);
                            },
                            child: Text('新用户注册',style: TextStyle(
                                fontSize: AppSize.sp(36),
                                color: Color(0xFF02A9FF)),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                width: Screen.width(),
                top: AppSize.height(260),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AvatarView(imgPath: 'images/logo.png',),
                  ],
                ),
              ),
              Positioned(
                left: AppSize.width(60),
                right: AppSize.width(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Checkbox(
                        value: true,
                        onChanged: (v){},
                      ),
                    ),

                    Text('我已阅读并同意遵守',style: TextStyle(
                        fontSize: AppSize.sp(30),
                      color: ThemeColor.subTextColor
                    )),
                    Text('《服务许可协议》',style: TextStyle(
                        fontSize: AppSize.sp(30),
                        decoration: TextDecoration.underline,
                        color: ThemeColor.hintTextColor
                    )),
                  ],
                ),
                bottom: AppSize.height(150)),

              Positioned(
                top: Screen.statusH()+AppSize.height(30),
                left: AppSize.width(30),
                child: InkWell(
                  onTap: (){
                    Routes.instance.navigateReplaceTo(context, Routes.ROOT ,"0");
                  },
                    child: Icon(YogaIcons.home,color: Colors.white,)),

              )
            ],
          ),
        ),
      ),
    );
  }
}
