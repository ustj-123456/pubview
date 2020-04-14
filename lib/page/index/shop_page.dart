import 'package:cyoga/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ShopPage extends StatefulWidget {
  ShopPage();
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  double lineProgress = 0.0;
  int f = 0;

  void initState() {
    super.initState();
    flutterWebviewPlugin.onProgressChanged.listen((progress){
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text(
      "商城",
      style: new TextStyle(color: Colors.white),
    ));
    titleContent.add(new Container(width: 50.0));
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return new WebviewScaffold(
      url: "http://app.cyogaschool.com/wap/",
      // 登录的URL
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          child: _progressBar(lineProgress,context),
          preferredSize: Size.fromHeight(3.0),
        ),
      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}

_progressBar(double progress,BuildContext context) {

  return LinearProgressIndicator(
    backgroundColor: Colors.white70.withOpacity(0),
    value: progress == 1.0 ? 0 : progress,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
  );
}
