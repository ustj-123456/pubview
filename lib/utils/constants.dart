import 'package:flutter/widgets.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/res/yoga_iconfont.dart';

const HEAD_NAV_TEXT = ["0", "1", "2", "3", "4", "5", "6", "7"];
const HEAD_PARTINS = ["8", "9", "10", "11", "12", "13", "14"];
const HEAD_MY = ["18", "19", "20", "21", "22", "23", "24", "25"];
const LINK_VUE = "http://app.cyogaschool.com:6255/#";
const LINK_WX = "http://app.cyogaschool.com:8080";

const Web_Links = {
  "0" : ["瑜伽分类",YogaIcons.g_yoga, Routes.CATEGORY],
  "1" : ["瑜伽商城",YogaIcons.g_shop],
  "2" : ["公开课",YogaIcons.g_gkk],
  "3" : ["新手必看",YogaIcons.g_xsbk],
  "4" : ["工作坊",YogaIcons.g_gzf],
  "5" : ["训练营",YogaIcons.g_train],
  "6" : ["行者计划",YogaIcons.g_schedule],
  "7" : ["场馆加盟",YogaIcons.g_jm],
  "8" : ["我的优惠券",YogaIcons.plottery],
  "9" : ["我的拼团",YogaIcons.ptuan],
  "10" : ["我的砍价",YogaIcons.pkanjia],
  "11" : ["关于麦伽",YogaIcons.pabout, Routes.webview_page, LINK_VUE +"/user/html/about"],
  "12" : ["关注麦伽",YogaIcons.phint],
  "13" : ["使用说明",YogaIcons.pdesc, Routes.webview_page, LINK_VUE +"/user/html/sjuse"],
  "14" : ["设置",YogaIcons.pset, Routes.PERSON_SETTING],
  "15" : ["忘记密码",YogaIcons.pset, Routes.webview_page, LINK_VUE + "/login/forget"],
  "16" : ["信息修改",YogaIcons.pset, Routes.webview_page, LINK_VUE + "/user/information"],
  "17" : ["我的订单",YogaIcons.pset],
  "18" : ["我的课程",YogaIcons.mycourse],
  "19" : ["我的收藏",YogaIcons.mycollect],
  "20" : ["我的关注",YogaIcons.mygz,Routes.PERSON_FELLOW],
  "21" : ["我的订单",YogaIcons.myorder, Routes.webview_page, LINK_VUE + "/user/order/list/0"],
  "22" : ["我的消息",YogaIcons.mymessage],
  "23" : ["我的浏览",YogaIcons.myview],
  "24" : ["我的勋章",YogaIcons.myhonor],
  "25" : ["我的钱包",YogaIcons.mywallent],
  "26" : ["购物车", YogaIcons.mywallent,Routes.webview_page,LINK_VUE + "/order"],
};


class Screen{
  static double _w;
  static double _statusH;

  static void init(BuildContext c){
    if(_w == null) {
      MediaQueryData mqd = MediaQuery.of(c);

      _w = mqd.size.width;
      _statusH = mqd.padding.top;
    }
  }

  static double width(){
    if(_w != null){
      return _w;
    }
    return 0;
  }

  ///
  /// 状态栏高度
  ///
  static double statusH(){
    if(_statusH != null){
      return _statusH;
    }
    return 0;
  }

}







