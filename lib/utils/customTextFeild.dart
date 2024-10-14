// ignore_for_file: file_names

import '../utils/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import 'constants/colors.dart';

Widget customTextFeild(
    TextEditingController controller,String lable,{ TextInputType? keyboard,Widget? prefixIcon,Widget? sufixIcon,TextAlign textalign = TextAlign.start,bool readOnly= false ,GestureTapCallback? onTap}) {
  return TextField(
    
    controller: controller,
    keyboardType: keyboard,
    textAlign: textalign,
    readOnly:readOnly ,
    onTap: onTap,
    style: appHeading(18,weight: FontWeight.w600, AppColor.primaryColor),
    decoration:InputDecoration(
      
      prefix: prefixIcon,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 50,
        maxHeight: 40
      ),
      suffix: sufixIcon,
      hintStyle: appHeading(16, AppColor.black),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: Text(lable,style: appHeadingBold(24, AppColor.primaryColor),),
        border: GradientOutlineInputBorder(
          borderRadius:BorderRadius.circular(15) ,
            width: 3,
            gradient: const LinearGradient(colors: [
              AppColor.primaryColor,
              AppColor.secondaryColor,
              AppColor.tertiary
            ], transform: GradientRotation(0.785)))),
  );
}
