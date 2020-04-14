
import 'package:cyoga/page/base/video_display.dart';
import 'package:cyoga/page/base/web_scaffold.dart';
import 'package:cyoga/page/category/category_list.dart';
import 'package:cyoga/page/details/courses_details.dart';
import 'package:cyoga/page/person/editprofile_page.dart';
import 'package:cyoga/page/person/follow_page.dart';
import 'package:cyoga/page/person/personal_page.dart';
import 'package:cyoga/page/person/setting_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/page/index/index_page.dart';
import 'package:cyoga/page/login/login_page.dart';
import 'package:cyoga/page/login/registered_page.dart';

class Routes {
  static Router router = new Router();
  static const ROOT = '/index_page';
  static const LOGIN_PAGE = '/login_page';
  static const PEORSON = 'person_page';
  static const CATEGORY = 'category_page';
  static const POINTS_MALL = '/points_mall';
  static const FAMOUS_BRAND = '/famous_brand';
  static const NEARBY_BUSINESS = '/nearby_business';
  static const FEMALE_CHANNEL = '/female_channel';
  static const STORE_LIVE = '/store_live';
  static const INVITE_FRIENDS = '/invite_friends';
  static const GOOD_SHOP = '/good_shop';
  static const POINTS_LOTTERY = '/points_lottery';
  static const NEW_SHOP = '/new_shop';
  static const SUPER_DISCOUNT = '/super_discount';

  static const PERSON_SETTING = '/person_setting_page';
  static const PERSON_FELLOW = '/follow_page';
  static const PERSON_PROFILE = '/profile_page';
  // details
  static const ORDER_DETAILS = '/order_details';
  static const PRODUCT_DETAILS = '/product_details';
  static const COURSE_DETAILS = '/course_details';
  static const store_details = '/store_details';
  static const V_DISLAY = '/video_display';

  // 个人中心二级界面
  static const favorite_page = '/favorite_page';

  static const my_scores = '/my_scores';
  static const edit_profile = '/edit_profile';
  static const shop_referrer = '/shop_referrer';
  static const card_voucher = '/card_voucher';
  static const my_fans = '/my_fans';
  static const income_record = '/income_record';
  static const shop_reward = '/shop_reward';
  static const registered_page = '/registered_page';


  // webview 链接页面
  static const webview_page = '/web_main';

  void _config() {
    router.define(
        '$ROOT/:type', handler:
    Handler(handlerFunc: (context, params) => IndexPage(params["type"][0])));

    router.define(
        LOGIN_PAGE, handler:
    Handler(handlerFunc: (context, params) => Login()));


    router.define(
        PERSON_SETTING, handler:
    Handler(handlerFunc: (context, params) => SettingPage()));

    router.define(
        PERSON_FELLOW, handler:
    Handler(handlerFunc: (context, params) => FollowPage()));

    router.define(
        PERSON_PROFILE, handler:
    Handler(handlerFunc: (context, params) => EditProfilePage()));

    router.define(
        PEORSON, handler:
    Handler(handlerFunc: (context, params) => PersonalPage()));

    router.define(
        '$COURSE_DETAILS/:id', handler:
    Handler(handlerFunc: (context, params) => CoursesDetailPage(int.parse(params['id'][0]))));

    router.define(
        '$V_DISLAY/:id', handler:
    Handler(handlerFunc: (context, params) => VideoDisplayPage(int.parse(params['id'][0]))));

    router.define(
        registered_page, handler:
    Handler(handlerFunc: (context, params) => Registered()));

    router.define(
        '$webview_page/:type', handler:
    Handler(handlerFunc: (context, params) => WebScaffold(params['type'][0])));

  }

  Future navigateTo(BuildContext context, String path,[String param='']){
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromRight);
  }

  Future navigateReplaceTo(BuildContext context, String path,[String param='']) {
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromRight, clearStack: true, replace: true);
  }

  Future navigateFromBottom(BuildContext context, String path,[String param='']){
    var p = param.isNotEmpty?'$path/$param':path;
    return router.navigateTo(context,p,transition: TransitionType.inFromBottom);
  }

  factory Routes() =>_getInstance();
  static Routes get instance => _getInstance();
  static Routes _instance;

  Routes._internal() {
    _config();
  }
  static Routes _getInstance() {
    if (_instance == null) {
      _instance = new Routes._internal();
    }
    return _instance;
  }
}
