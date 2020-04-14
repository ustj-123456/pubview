
import 'package:cyoga/models/store_entity.dart';
import 'package:cyoga/models/goods_entity.dart';
import 'package:cyoga/models/courses_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "StoreEntity") {
      return StoreEntity.fromJson(json) as T;
    } else if (T.toString() == "GoodsEntity"){
      return GoodsEntity.fromJson(json) as T;
    }else if (T.toString() == 'CoursesEntity'){
      return CoursesEntity.fromJson(json) as T;
    }else {
      return null;
    }
  }
}
