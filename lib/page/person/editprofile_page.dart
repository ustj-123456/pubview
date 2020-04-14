import 'dart:io';

import 'package:cyoga/page/base/com_scaffold.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/widget/common/custom_view.dart';
import 'package:flutter/material.dart';

///
/// 完善资料页
///
class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {


  @override
  Widget build(BuildContext context) {
    return  ComScaffold(
      title: "完善资料",
      titleId: "",
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: .5,
              indent: 20,
              endIndent: 20,
              color: ThemeColor.textBorderColor,
            );
          },
          itemCount: 3,
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            if(index==0) {
              return InkWell(
                onTap: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("头像")
                    ),
                    new Row(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 10, bottom: 10),
                            child: new AvatarView()
                        ),
                        new Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, left: 10.0),
                            child: Icon(YogaIcons.pentry, size: AppSize.sp(50),
                                color: ThemeColor.textCustomColor))
                      ],
                    ),
                  ],
                ),
              );
            }else if(index==1){
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text("密码设置")
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 10, bottom: 10),
                          child: Text("保密")
                      ),
                      new Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 10.0),
                          child: Icon(YogaIcons.pentry, size: AppSize.sp(50),
                              color: ThemeColor.textCustomColor))
                    ],
                  ),
                ],
              );
            }else {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                      child: Text("手机号")
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 10.0),
                          child: Icon(YogaIcons.pentry, size: AppSize.sp(50),
                              color: ThemeColor.textCustomColor))
                    ],
                  ),
                ],
              );
            }
          }
      )
    );
  }
}
