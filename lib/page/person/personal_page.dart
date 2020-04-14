import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/widget/common/custom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:provider/provider.dart';
import '../../res/theme_ui.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> with AutomaticKeepAliveClientMixin {
  List<Widget> contentList;
  UserModel userModel;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> generateList(BuildContext ctx) {
    if (contentList == null) {
      contentList = new List<Widget>();
      contentList.add(createHeadInfo(ctx));
      contentList.add(createMyContent(ctx, 3, 0));
      contentList.add(createMyContent(ctx, 3, 3));
      contentList.add(createMyContent(ctx, 1, 6));
    }
    return contentList;
  }

  Widget createPartins(index) {
    var j = HEAD_PARTINS[index];
    var links = Web_Links[j];
    var iconColor = links.length>2 ? ThemeColor.appMain : ThemeColor.textCustomColor;
    var textColor = links.length>2 ? ThemeColor.hintTextColor : ThemeColor.textCustomColor;
    return new Container(
        color: Colors.white,
        height: 50.0,
        child:new InkWell(
          onTap: () {
            if(links.length >2) {
              if(links.length >3) {
                Routes.instance.navigateTo(context, links[2], j);
              }else {
                Routes.instance.navigateTo(context, links[2]);
              }
            }
          },
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(links[1],size: AppSize.sp(50), color: iconColor,)
                  ),

                  new Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: new Text(links[0],
                        style: new TextStyle(fontSize: 14.0, color: textColor),)),
                ],
              ),
              new Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                  child: Icon(YogaIcons.pentry,size: AppSize.sp(50), color: ThemeColor.textCustomColor))
              ],
          ),
        )
    );
  }

  // 我的内容
  createMyContent(BuildContext ctx, int num,  int step) {
    return Container(
            margin: EdgeInsets.all( AppSize.width(20)),
            decoration: BoxDecoration(
              border: new Border.all(width: 1,color: ThemeColor.textBorderColor,),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: .5,
                      indent: 20,
                      endIndent: 20,
                      color: ThemeColor.textBorderColor,
                    );
                  },
                  itemCount: num,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return createPartins(index + step);
                  }
              ),
            )
    );
  }

  createHeadInfo(BuildContext ctx) {
    return Stack(
        children: <Widget>[
          Container(height: 260),
          Positioned(
            child: Container(
              color: ThemeColor.appMain,
              height: 160,
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Routes.instance.navigateTo(context, Web_Links["16"][2], "16");
                    },
                    child: AvatarView()
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("名称：" + userModel.nickname, style: TextStyle(color: Colors.white)),
                                Text("ID：" + userModel.id.toString(), style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("勋章等级：" + userModel.userLevel.toString() ?? 0, style: TextStyle(color: Colors.white)),
                                Text("学习时长：" + userModel.studyTime.toString() ?? 0, style: TextStyle(color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSize.sp(20),
            right: AppSize.sp(20),
            bottom: 0,
            child: Container(
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: createToolBar(),
              )
            )
          )
        ],
      );
  }

  createAdBar() {
    return AdBarView(Image.asset("images/personal_ad.png",fit: BoxFit.cover), AppSize.height(200),
        bottom: AppSize.height(30),
        left: AppSize.height(30),
        right: AppSize.height(30));
  }

  createToolBar() {
    _getImgBtns(int op) {
      int i = op == 0 ? 0 : 4;
      int offset = 4 - i;
      var imageBtns = List<Widget>();
      for (; i < HEAD_MY.length - offset; i++) {
        var j = HEAD_MY[i];
        var link = Web_Links[j];
        var iconColor = link.length>2 ? ThemeColor.appMain : ThemeColor.textCustomColor;
        var textColor = link.length>2 ? ThemeColor.hintTextColor : ThemeColor.textCustomColor;
        imageBtns.add(
            IconBtn(
                link[1],
                func: navigateTo,
                index: j,
                text:link[0],
                iconColor: iconColor,
                textStyle: TextStyle(color: textColor),
            ));
      }
      return imageBtns;
    }

    return Container(
        decoration: ThemeDecoration.card,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getImgBtns(0),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getImgBtns(1),
              ),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var userProvider = Provider.of<UserProviderModel>(context);
    userModel = userProvider.userModel;
    return Container(
        color: ThemeColor.textColor,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(children: generateList(context),
              physics:ClampingScrollPhysics()
          ),
        )
    );
  }

  void navigateTo(String index){
    print(index);
    if(Web_Links[index]!=null) {
      var links = Web_Links[index];
      if(links.length >2) {
        Routes.instance.navigateTo(context, links[2], "21");
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
