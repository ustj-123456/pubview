import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/page/index/shop_page.dart';
import 'package:cyoga/page/index/shopcart_page.dart';
import 'package:cyoga/page/index/shopcategory_page.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/upgrade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/page/index/home_page.dart';
import 'package:cyoga/page/person/personal_page.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  final String type;
  IndexPage(this.type);
  @override
  _IndexPageState createState() => _IndexPageState();
}

final List<BottomNavigationBarItem> bottomBar = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(YogaIcons.home,size: AppSize.width(55)), title: Text("首页")),
  BottomNavigationBarItem(icon: Icon(YogaIcons.category,size: AppSize.width(55)), title: Text("分类")),
  BottomNavigationBarItem(icon: Icon(YogaIcons.shop,size: AppSize.width(55)), title: Text("商城")),
  BottomNavigationBarItem(icon: Icon(YogaIcons.cart,size: AppSize.width(55)), title: Text("购物车")),
  BottomNavigationBarItem(icon: Icon(YogaIcons.mine,size: AppSize.width(55)), title: Text("我的"))
];

final List<Widget> pages = <Widget>[
  HomePage(),
  ShopCategoryPage(),
  ShopPage(),
  ShopCartPage(),
  PersonalPage(),
];

class _IndexPageState extends State<IndexPage>  with AutomaticKeepAliveClientMixin{
  int currentIndex = 0;
  DateTime lastPopTime;
  var pageController;
  @override
  void initState() {
    super.initState();
    new Upgrade()..checkUpdate(context);
    currentIndex = widget.type != null ? int.parse(widget.type) : 0;
    pageController = new PageController(initialPage: currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 初始化屏幕适配包
    AppSize.init(context);
    Screen.init(context);
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: this.currentIndex,
              onTap: (index) {
                if(index==2) return;
                // 判断是否已经登录
                var userProvider = Provider.of<UserProviderModel>(context);
                var token = userProvider.userModel.token ?? "";
                setState(() {
                  if(token.isEmpty && index >2) {
                    Routes.instance.navigateTo(context, Routes.LOGIN_PAGE);
                  }else if(index!=1){
                    this.currentIndex = index;
                    pageController.jumpToPage(index);
                  }
                });
              },
              items: bottomBar),
          body: _getPageBody(context),
        ),
        onWillPop: () async{
          // 点击返回键的操作
          if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
            lastPopTime = DateTime.now();
            Fluttertoast.showToast(
                msg: "再按一次退出",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos:1
            );
          }else{
            lastPopTime = DateTime.now();
            // 退出app
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      );
  }
  _getPageBody(BuildContext context){
    return PageView(
      controller: pageController,
      children: pages,
      physics: NeverScrollableScrollPhysics(), // 禁止滑动
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
