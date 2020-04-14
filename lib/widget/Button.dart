import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CyogaButton extends StatelessWidget {

  final Color color;
  final String text;
  final Object cb;
  final double height;
  CyogaButton({Key key,this.color=Colors.black,this.text='按钮',this.cb=null,this.height=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:this.cb,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.all(2),
        height: this.height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
