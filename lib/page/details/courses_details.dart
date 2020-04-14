import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyoga/dao/courses_dao.dart';
import 'package:cyoga/res/theme_ui.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/widget/Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class _Page {
  _Page({this.label, this.index});

  final String label;
  final int index;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}


final Map<_Page, List<Widget>> _allPages = <_Page, List<Widget>>{
  new _Page(label: '介绍', index: 0): [],
  new _Page(label: '视频', index: 1): [],
  new _Page(label: '评价', index: 2): [],
};


class CoursesDetailPage extends StatefulWidget {
  final int id;
  CoursesDetailPage(this.id);
  @override
  State createState() => new _CoursesDetailPageState(id);
}

class _CoursesDetailPageState extends State<CoursesDetailPage> {
  final int id;
  // 初始化数据
  Map<String, dynamic> baseinfo = {
    "goods_name": "",
    "label": "",
    "level": "",
    "goods_body": ""
  };

  _CoursesDetailPageState(this.id);
  String mPhoneText;
  List<dynamic> bannerDatas = List();
  List<dynamic> videoDatas = List();
  SwiperController _swiperController;
  void onItemClick(id) {
    Routes.instance.navigateTo(context, Routes.V_DISLAY,id.toString());
  }
  Widget doVideoRect(List list, index) {
    if(list==null || index==null || list.length<= index) return null;
    Map<String, dynamic> map = list.elementAt(index);
    String picSubFix = "?x-oss-process=video/snapshot,t_10000,m_fast,w_200,h_100,f_png";
    return Container(
        height: AppSize.height(250),
        child:InkWell(
          onTap: ()=>onItemClick(map["id"]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(child: CachedNetworkImage(imageUrl: map["vhtml5"]+ picSubFix, fit: BoxFit.fill,),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      Positioned(
                        left: 55,
                        top: 20,
                        width: 40,
                        height:40,
                        child: Icon(YogaIcons.start, size:40, color: Colors.white,),
                      ),
                    ],)
              ),
              SizedBox(width: 10,),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(map["title"]),
                      Text.rich(TextSpan(
                          text: map["remark"]
                      ))
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
  void _getDio() async {
    var details = await CoursesDao.fetchDetail(this.id);
    var info = new HashMap<String,dynamic>();
    var imgs = new List();
    var videos = new List();
    var label = "";

    if(details["errno"] == 0) {
      var data = details["data"];
      videos = data["videos"] ?? new List();
      if(data["info"]!=null) {
        imgs.add(data["info"]["picUrl"]);
        if(data["info"]["gallery"]!=null) {
          imgs.addAll(data["info"]["gallery"]);
        }
        info["goods_name"] = data["info"]["name"] ?? "";
        info["goods_body"] = data["info"]["detail"] ?? "";
      }
      if(data["attribute"]!=null && data["attribute"].length >0) {
        data["attribute"].forEach((attr){
          if(attr["attribute"]=='level') {
            info["level"] = attr["value"] ?? "";
          }else{
            if(label!="") label+=",";
            label+= attr["value"];
          }
        });
      }
      info["label"] = label;
    }
    setState(() {
      baseinfo = info;
      bannerDatas = imgs;
      videoDatas = videos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _swiperController = SwiperController();
    _getDio();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        body: new NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: new SliverAppBar(
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.black,),
                      onTap: () => Navigator.pop(context),
                    ), //左侧按钮
                    pinned: true,
                    expandedHeight: 420,
                    // 这个高度必须比flexibleSpace高度大
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                        child: new Container(
                          child: new TabBar(
                            labelColor: Colors.black,
                            indicatorColor: ThemeColor.appMain,//选中下划线颜色,如果使用了indicator这里设置无效
                            labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                            unselectedLabelStyle:TextStyle(fontSize: 14, color: Colors.black) ,
                            indicatorWeight: 1,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: _allPages.keys
                                .map(
                                  (_Page page) => new Tab(
                                child: new Tab(text: page.label),
                              ),
                            ).toList(),
                          ),
                          color: ThemeColor.textCustomColor,
                        ),
                        preferredSize: new Size(double.infinity, 45.0)
                    ),
                    // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(YogaIcons.myshare, color: ThemeColor.subTextColor,),
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "正在建设中...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos:1
                          );
                        },
                      ),
                    ],
                    flexibleSpace: new Container(
                      color: Colors.white,
                      child: new Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: <Widget>[
                          new AppBar(
                            elevation: 0,
                            centerTitle: true,
                            backgroundColor:Colors.white,
                            title: Text(baseinfo["goods_name"]??"", style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Expanded(
                            flex:1,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex:1,
                                    child: new Swiper(
                                      itemBuilder: (BuildContext context,int index){
                                        return new Image.network(bannerDatas[index],fit: BoxFit.fill,);
                                      },
                                      itemCount: bannerDatas.length,
                                      //触发时是否停止播放
                                      autoplayDisableOnInteraction: true,
                                      //默认分页按钮
                                      controller: _swiperController,
                                      //autoplay: true,
                                      onTap: (index) => Fluttertoast.showToast(
                                          msg: "点击了第$index个",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos:1
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(left:10,right:10,bottom: 60, top: 10),
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(baseinfo["goods_name"] ?? "",style: TextStyle(
                                                fontSize: AppSize.sp(36),
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold
                                            )),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text.rich(
                                                  TextSpan(
                                                      style: TextStyle(
                                                        color: ThemeColor.subTextColor,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text: "难度："
                                                        ),
                                                        TextSpan(
                                                            text: baseinfo["level"]
                                                        )
                                                      ]
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                      style: TextStyle(
                                                        color: ThemeColor.subTextColor,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                            text: "0"
                                                        ),
                                                        TextSpan(
                                                            text: " 人参加"
                                                        )
                                                      ]
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("未购买" ,style: TextStyle(
                                                    color: ThemeColor.appMain
                                                ),),
                                                Text("试看中", style: TextStyle(
                                                    color: ThemeColor.subTextColor
                                                ),)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Text("标签：", style: TextStyle(
                                                    color: ThemeColor.subTextColor,
                                                )),Text(baseinfo["label"] ?? "",style: TextStyle(
                                                  color: ThemeColor.appMain,
                                                    fontWeight: FontWeight.bold
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: new Stack(
                children: <Widget>[
                  new TabBarView(
                    children: _allPages.keys.map((_Page page) {
                      //SafeArea 适配刘海屏的一个widget
                      return new SafeArea(
                        top: false,
                        bottom: false,
                        child: new Builder(
                          builder: (BuildContext context) {
                            int childCount = 1;
                            if(page.index==1) {
                                childCount = videoDatas.length;
                            }
                            return new CustomScrollView(
                              key: new PageStorageKey<_Page>(page),
                              slivers: <Widget>[
                                new SliverOverlapInjector(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context),
                                ),
                                new SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 16.0,
                                  ),
                                  sliver: new SliverList(
                                    delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {
                                        Widget content;
                                        // 介绍
                                        switch(page.index) {
                                          case 0: content = new Html(data: baseinfo["goods_body"] ?? ""); break;
                                          case 1: content = doVideoRect(videoDatas, index); break;
                                          case 2: content = new Text("评论");break;
                                          default:;
                                        }
                                        return new Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: content,
                                        );
                                      },
                                      childCount: childCount,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ), Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: ScreenUtil().setHeight(140),
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xFFe5e5e5), width: 1)),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                              width: 60,
                              height: ScreenUtil().setHeight(100),
                              child:
                              new InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "正在建设中...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos:1
                                  );
                                },
                                child:Column(
                                  children: <Widget>[
                                    Icon(
                                      YogaIcons.myhome,
                                      size: AppSize.sp(40),
                                      color: ThemeColor.textCustomColor,
                                    ),
                                    Text('首页',  style: new TextStyle(fontSize: AppSize.sp(36),
                                        color:const Color(0xFF666666)))
                                  ],
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                              width: 60,
                              height: ScreenUtil().setHeight(100),
                              child:
                              new InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "正在建设中...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos:1
                                  );
                                },
                                child:Column(
                                  children: <Widget>[
                                    Icon(
                                      YogaIcons.mymessage,
                                      size: AppSize.sp(40),
                                      color: ThemeColor.textCustomColor,
                                    ),
                                    Text('咨询',  style: new TextStyle(fontSize: AppSize.sp(36),
                                        color:const Color(0xFF666666)))
                                  ],
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                              width: 60,
                              height: ScreenUtil().setHeight(100),
                              child:
                              new InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "正在建设中...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos:1
                                  );
                                },
                                child:Column(
                                  children: <Widget>[
                                    Icon(
                                      YogaIcons.mycollect,
                                      size: AppSize.sp(40),
                                      color: ThemeColor.textCustomColor,
                                    ),
                                    Text('收藏',   style: new TextStyle(fontSize: AppSize.sp(36),
                                        color:const Color(0xFF666666)))
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: CyogaButton(
                              color: ThemeColor.appMain,
                              text: "立即购买",
                              height: ScreenUtil().setHeight(100),
                              cb: (){
                                Fluttertoast.showToast(
                                    msg: "正在建设中...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos:1
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ])
        ),
      ),
    );
  }

  Widget dividerWidget=new Container(
      child: new Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
      )
  );

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }
}
