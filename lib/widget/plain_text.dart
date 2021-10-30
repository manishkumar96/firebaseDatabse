import 'package:firebase_database/resource_helper/dimens_helper.dart';
import 'package:flutter/material.dart';

class PlainText extends StatelessWidget {

 final String? text;
 final  TextStyle? textStyle;
 final Color? color;
 final TextAlign? textAlign;

   const PlainText({ required this.text, this.textStyle, Key? key, this.color, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimensHelper.ten),
              bottomLeft: Radius.circular(DimensHelper.ten),
              bottomRight: Radius.circular(DimensHelper.ten))),
      color: color,
      child: Text(text!,style: textStyle,textAlign: textAlign,),
    );
  }
}
