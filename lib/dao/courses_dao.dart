import 'dart:collection';

import 'package:cyoga/utils/http_util.dart';
const URL = '/wx/goods/detail';
class CoursesDao{
  static fetchDetail(int id) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["id"] = id;
      var httputil = await HttpUtil.getInstance();
      return await httputil.get(URL, data: params);
    } catch (e) {
      print(e);
    }
  }

}
