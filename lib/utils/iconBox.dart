// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  final double iconSize;
  final Color iconBg;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final bool wantIcon;

  const IconBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.titleStyle,
    required this.subtitleStyle, required this.wantIcon, required this.iconSize,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          wantIcon?
         CircleAvatar(
            backgroundColor: iconBg,
            radius: iconSize,
            child: icon,
          ):const SizedBox.shrink(),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment:wantIcon?CrossAxisAlignment.start:CrossAxisAlignment.center,
            children: [
              Text(
                subtitle,
                style: subtitleStyle,
              ),
              Text(
                title,
                style: titleStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
