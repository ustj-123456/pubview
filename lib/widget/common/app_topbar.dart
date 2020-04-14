import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:cyoga/res/yoga_iconfont.dart';

class HomeTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Container(
              height: AppSize.height(100),
              decoration: BoxDecoration(
                  color: ThemeColor.textColor, borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 5 , bottom: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.search,
                        color: Color(0xff999999),
                        size: AppSize.width(40),
                      ),
                      Text("搜索课程、老师、体系、功效等",
                          style: TextStyle(fontSize:AppSize.sp(35), color: Color(0xff999999)))
                    ],
                  )),
            )),
        SizedBox(
          width: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(YogaIcons.custom,color: ThemeColor.textCustomColor)
            ],
          ),
        )
      ],
    );
  }
}

class CommonTopBar extends StatelessWidget {
  final String title;

  CommonTopBar({
    @required this.title
});

  @override
  Widget build(BuildContext context) {
    return Center(child:
      Text(title,style: TextStyle(color: Colors.white,fontSize: AppSize.sp(52))));
  }
}

class CommonBackTopBar extends StatelessWidget {
  final String title;
  final Function onBack;

  CommonBackTopBar({
    @required this.title,
    this.onBack
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: Text(title,
            style: TextStyle(color: Colors.white,fontSize: AppSize.sp(52)))),
        InkWell(
          onTap: onBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: AppSize.width(20)),
              child: Icon(YogaIcons.home,color: Colors.white,size: AppSize.height(60)),
            )
          ],),
        )
      ],
    );
  }
}

