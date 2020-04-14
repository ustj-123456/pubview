import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/3.0x/$name.$format';
  }

  static String getTimeLine(BuildContext context, int timeMillis) {
    return TimelineUtil.format(timeMillis,
        locale: Localizations
            .localeOf(context)
            .languageCode,
        dayFormat: DayFormat.Common);
  }
}
