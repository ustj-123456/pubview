import 'package:cyoga/dao/video_dao.dart';
import 'package:cyoga/widget/videos/video/video_player_UI.dart';
import 'package:flutter/material.dart';
class VideoDisplayPage extends StatefulWidget {
  final int id;
  VideoDisplayPage(this.id);
  @override
  State createState() {
    return new _VideoDisplayPage(this.id);
  }
}

class _VideoDisplayPage extends State<VideoDisplayPage> {
  final int id;
  var url ="1";
  var title = "1";
  _VideoDisplayPage(this.id);
  @override
  void initState() {
    super.initState();
    //初始化时即进行数据请求
    _getDio();
  }
  void _getDio() async {
    var details = await VideosDao.fetchDetail(this.id);
    setState(() {
      if(details!=null && details["errno"] ==0) {
        this.title  = details["data"]["video"]["title"];
        this.url  = details["data"]["video"]["vhtml5"];
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // 该组件宽高默认填充父控件，你也可以自己设置宽高
        child: VideoPlayerUI.network(
          url: this.url,
          title: this.title,
        ),
      ),
    );
  }

}

