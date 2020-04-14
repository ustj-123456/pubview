import 'package:dio/dio.dart';
import 'package:cyoga/models/entity_factory.dart';
import 'package:cyoga/models/store_entity.dart';

const HOME_URL = '/wx/store/list';
class HomeDao{

  static Future<StoreEntity> fetch() async{
    try {
      Response response = await Dio().get(HOME_URL);

      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<StoreEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




