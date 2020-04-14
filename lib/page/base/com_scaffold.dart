import 'package:cyoga/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/common/libs.dart';

class ComScaffold extends StatelessWidget {
  const ComScaffold({
    Key key,
    this.title,
    this.titleId,
    this.body,
  }) : super(key: key);

  final String title;
  final String titleId;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title ?? IntlUtil.getString(context, titleId),
          style: TextStyles.appTitle,
        ),
        centerTitle: true,
      ),
      body: body,
    );
  }
}
