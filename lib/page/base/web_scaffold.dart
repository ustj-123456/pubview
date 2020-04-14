import 'package:cyoga/models/user_entity.dart';
import 'package:cyoga/models/user_provider.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:cyoga/utils/dbutil.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/common/libs.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold(this.titleId,{
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  String title = "";
  String titleId = "";
  String url = "";
  double lineProgress = 0.0;
  void initState() {
    // 初始化数据
    titleId = widget.titleId;
    title = widget.title ?? Web_Links[titleId][0];
    url = widget.url ?? Web_Links[titleId][3];
    super.initState();
    flutterWebviewPlugin.onProgressChanged.listen((progress){
      setState(() {
        lineProgress = progress;
      });
    });

    flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        //加载完成
        var userModel = Provider.of<UserProviderModel>(context).userModel;
        String token = userModel.token ?? "";
        flutterWebviewPlugin.evalJavascript("returnJs('${token}')").then((val){ print("#################"+val);});

      }
    });
  }

  _progressBar(double progress,BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.amberAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'JSCMD',
          onMessageReceived: (JavascriptMessage message) {
            String cmd =  message.message;
            print(cmd);
            if(cmd == "RP") {
              Routes.instance.navigateReplaceTo(context, Routes.ROOT, "0");
            }
            if(cmd == "RL") {
              Fluttertoast.showToast(
                  msg: "token失效，重新登录",
                  gravity: ToastGravity.CENTER
              ).then((v){
                Provider.of<UserProviderModel>(context).set(new UserModel());
                SharedPreferenceUtil.delete("token");
                Routes.instance.navigateReplaceTo(context, Routes.LOGIN_PAGE);
              });
            }
          }),
    ].toSet();

    return new WebviewScaffold(
      url: url,
      // 登录的URL
      appBar:new AppBar(
        title: new Text(
          title ?? IntlUtil.getString(context, titleId),
          maxLines: 1,
          style: new TextStyle(
              color: Colours.text_dark,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              fontWeight: FontWeight.normal),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          child: _progressBar(lineProgress,context),
          preferredSize: Size.fromHeight(1.0),
        ),

      ),
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      hidden: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
    );
  }
  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    flutterWebviewPlugin.cleanCookies();
    flutterWebviewPlugin.close();
    super.dispose();
  }
}
