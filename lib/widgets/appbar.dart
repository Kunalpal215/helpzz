import 'package:flutter/material.dart';
import 'package:helpzz/globals/my_fonts.dart';
import '../globals/colors.dart';

PreferredSizeWidget appBar(final size){
  return AppBar(
    backgroundColor: kBackground,
    iconTheme: const IconThemeData(color: kAppBarGrey),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Helpzzz",
          textAlign: TextAlign.center,
          style:
          MyFonts.w600.size(23).letterSpace(1.0).setColor(lBlue2),
        )
      ],
    ),
    centerTitle: true,
  );
}
