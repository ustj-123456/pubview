import 'dart:collection';
import 'package:cyoga/utils/http_util.dart';
import 'package:cyoga/models/entity_factory.dart';
import 'dart:async';
import 'package:cyoga/models/courses_entity.dart';

const HOME_URL = '/wx/goods/hotlist';

class HomeHotDao{

  static Future<CoursesEntity> fetch(int type,int minId) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["type"] = type;
      params["minId"] = minId;

      var httputil = await HttpUtil.getInstance();
      var res =  await httputil.get(HOME_URL, data: params);

      var data = new HashMap<String, dynamic>();
      data["courses"] = [];
      data["status"] =1;
      if(res["errno"]==0) {
        data["courses"] = res["data"]["list"];
      }
      return EntityFactory.generateOBJ<CoursesEntity>(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

}




