import 'package:flutter/material.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:helpzz/models/user.dart';
import 'package:helpzz/pages/auth/signin.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';

PreferredSizeWidget appBar(final size,bool check){
  return AppBar(
    backgroundColor: kBackground,
    iconTheme: const IconThemeData(color: kAppBarGrey),
    leading: check==true ?  Builder(builder: (context){
      return GestureDetector(onTap: () async {
        await context.read<User>().logout();
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Logged out successfully")));
        Navigator.pushNamed(context, LoginScreen.id);
      }, child: Icon(Icons.logout_rounded,size: 28,color: kWhite,));
    }) : Container(),
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
