import 'package:shared_preferences/shared_preferences.dart';

///数据库相关的工具
class SharedPreferenceUtil {

  static void delete(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  static void put(String key, String value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static Future<String> query(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String  str = sp.getString(key);
    return str;
  }

}
