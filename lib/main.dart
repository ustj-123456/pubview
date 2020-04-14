import 'dart:io';
import 'package:cyoga/page/index/splash_page.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'models/user_provider.dart';

void main() {
  runApp(cyogaApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class cyogaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => UserProviderModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new SplashPage(),
          theme: ThemeData(
              primarySwatch: Colors.teal
          ),
          onGenerateRoute: Routes.router.generator,
        ),
    );
  }
}
