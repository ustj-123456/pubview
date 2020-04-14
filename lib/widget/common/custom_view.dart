import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyoga/routes/routes.dart';
import 'package:cyoga/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cyoga/models/order_form_entity.dart';
import 'package:cyoga/utils/app_size.dart';
import 'package:cyoga/res/theme_ui.dart';

typedef ImgBtnFunc = void Function(String);

class ImageButton extends StatelessWidget {
  double width;
  double height;
  double iconSize;
  Color iconColor;
  String assetPath;
  String text;
  String index;

  TextStyle textStyle;
  ImgBtnFunc func;


  ImageButton(this.assetPath,
      {this.width, this.height, this.iconSize, this.text, this.textStyle
      ,this.func, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(index),
      child: SizedBox(
//      width: this.width,
//      height: this.height,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(assetPath),
//              width: iconSize,
//              height: iconSize,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(text, style: textStyle),
              )
            ]),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  double iconSize;
  Color iconColor;

  final IconData icon;
  String text;
  String index;

  TextStyle textStyle;
  ImgBtnFunc func;

  IconBtn(this.icon,
      {this.iconColor, this.text, this.textStyle, this.index
        ,this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>func(this.index??text),
      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: iconColor),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(text, style: textStyle),
              )
            ]),
    );
  }
}

class AvatarView extends StatelessWidget {
  String imgPath;
  AvatarView({this.imgPath});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppSize.width(150),
        height: AppSize.width(150),
        child: ClipOval(
            child: Image.asset(
              imgPath == null?"images/default_avatar.png":imgPath,
              fit: BoxFit.cover,
            )
        ),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      );
  }
}

class AdBarView extends StatelessWidget {
  final Image image;
  final double height;
  double left;
  double top;
  double right;
  double bottom;

  AdBarView(this.image, this.height,
      {this.left = 0.0, this.top = 0.0, this.right = 0.0, this.bottom = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(
          top:top, left: left, right: right, bottom: bottom),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6)),
      child: ClipRRect(child: image, borderRadius: BorderRadius.circular(6)),
    );
  }
}

class ThemeCard extends StatelessWidget {
  final String title;
  final String price;
  final String number;
  final String imgUrl;

  ThemeCard({
    this.title,
    this.price,
    this.number,
    this.imgUrl
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(30)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
          child:Image(image:CachedNetworkImageProvider(imgUrl),fit: BoxFit.cover,))
          ,
          Padding(
              child: Text(title,style: ThemeTextStyle.cardTitleStyle,
                  maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price,style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(number,style: ThemeTextStyle.cardNumStyle))
        ],
      ),
    );
  }
}

class ThemeBtnCard extends StatelessWidget {
  final String title;
  final String price;
  final String imgUrl;

  ThemeBtnCard({
    this.title,
    this.price,
    this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppSize.height(20)),
      decoration: ThemeDecoration.card2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              child:Image(image:CachedNetworkImageProvider(imgUrl),fit: BoxFit.cover,))
          ,
          Padding(
              child: Text(title,style: ThemeTextStyle.cardTitleStyle,
                maxLines:2,overflow: TextOverflow.clip,
              ),
              padding: EdgeInsets.all(AppSize.width(30))),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Text(price,style: ThemeTextStyle.cardPriceStyle)),
          Padding(
              padding: EdgeInsets.only(left: AppSize.width(30)),
              child:Image.asset("images/exchange_btn.png",fit: BoxFit.cover))
        ],
      ),
    );
  }
}



class Badge extends StatelessWidget {
  final String text;

  Badge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1,horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.subTextColor),
        borderRadius: BorderRadius.circular(2)
      ),
      child: Text(text,style: TextStyle(
        fontSize: AppSize.sp(24),
        color: ThemeColor.hintTextColor
      ),),
    );
  }
}

