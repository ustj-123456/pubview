import 'dart:collection';

import 'package:cyoga/utils/http_util.dart';
const baseURL = '/wx/auth';
class UserDao{
  static fetchDetail(int id) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["id"] = id;
      var httputil = await HttpUtil.getInstance();
      return await httputil.get(baseURL + "/info", data: params);
    } catch (e) {
      print(e);
    }
  }
  static login(String userName, String password) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["username"] = userName;
      params["password"] = password;
      var httputil = await HttpUtil.getInstance();
      return await httputil.post(baseURL + "/login", data: params);
    } catch (e) {
      print(e);
    }
  }

  static sendCode(String phone) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["mobile"] = phone;
      var httputil = await HttpUtil.getInstance();
      return await httputil.post(baseURL + "/regCaptcha", data: params);
    } catch (e) {
      print(e);
    }
  }

  static register(String code, String mobile, String password) async{
    try {
      var params = new HashMap<String, dynamic>();
      params["code"] = code;
      params["mobile"] = mobile;
      params["password"] = password;
      params["repeatPassword"] = password;
      params["username"] = mobile;
      var httputil = await HttpUtil.getInstance();
      return await httputil.post(baseURL + "/register", data: params);
    } catch (e) {
      print(e);
    }
  }
}
