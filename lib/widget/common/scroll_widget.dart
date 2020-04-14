import 'package:cyoga/res/theme_ui.dart';
import 'package:cyoga/res/yoga_iconfont.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/utils/http_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef LoadFunc = Future<List> Function(int,int);
typedef OnTabClick = Function();
typedef DefWidgetBuilder = Widget Function(BuildContext context, int index, List);

class ScrollWidget extends StatefulWidget{
  static int REFRESH =0;
  static int MORE = 1;
  final String url;
  bool extra = false;
  LoadFunc loadFunc;
  @required DefWidgetBuilder builder;

  ScrollWidget({
    Key key,
    this.url,
    this.builder,
    this.loadFunc,
    this.extra,
  }):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new _ScrollWidget(this.url,this.loadFunc, this.builder, this.extra);
  }
}

class _ScrollWidget extends State<ScrollWidget> with SingleTickerProviderStateMixin {

  GlobalKey <RefreshHeaderState> _headerKey =  new  GlobalKey <RefreshHeaderState>();
  GlobalKey <RefreshFooterState> _footerKey =  new  GlobalKey <RefreshFooterState>();
  List list = null;
  final String _url;
  bool _extra = false;
  LoadFunc _loadFunc;
  DefWidgetBuilder _itemBuilder;
  int minId =0;

  _ScrollWidget(this._url, this._loadFunc, this._itemBuilder, this._extra) : super();
  @override
  void initState() {
    super.initState();
    loadRenderData(ScrollWidget.REFRESH);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Color(0xfff5f6f7),
          child: list == null? Center(
              child: CircularProgressIndicator()):_buildList()
    );
  }

  Widget _buildList(){
    int len = list?.length;

    return EasyRefresh(
        refreshHeader: ClassicsHeader(
          bgColor: ThemeColor.scollbg,
          refreshText:"下拉触发",
          textColor: ThemeColor.appMain,
          refreshReadyText:"释放刷新",
          refreshingText: "刷新中...",
          refreshedText: "已刷新",
          moreInfoColor: ThemeColor.appMain,
          showMore:true,
          moreInfo: "更新时间 %T",
          key: _headerKey,
        ),
        refreshFooter: ClassicsFooter(
          bgColor: ThemeColor.scollbg,
          textColor: ThemeColor.appMain,
          loadText:"上拉触发",
          loadReadyText:"加载更多",
          loadingText:"正在加载",
          loadedText:"加载完成",
          noMoreText:"没有更多",
          key: _footerKey,
        ),

        onRefresh: () async {
          loadRenderData(ScrollWidget.REFRESH);
        },
        loadMore: () async {
          loadRenderData(ScrollWidget.MORE);
        },
        child: ListView.builder(
          itemCount: this._extra ? len +1 : len,
          itemBuilder: (BuildContext context, int index){
            return _itemBuilder.call(context, index, list);
          },
        ));
  }

  void loadRenderData(int type) async {
    var res =new List();
    if (_loadFunc != null) {
      res = await _loadFunc.call(type, minId);
    }else {
      var data = await HttpUtil.instance.get(this._url);
      res = data["data"] ?? [];
    }
    setState(() {
     if(type==1) {
       list.addAll(res);
     }else {
       list = res;
     }
     minId = 0;
     if(res.length >0){
       var item = res.elementAt(res.length -1);
       minId = item.id;
     }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
