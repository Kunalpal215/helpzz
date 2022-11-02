import 'package:flutter/material.dart';
import 'package:helpzz/globals/colors.dart';
class SavingOverlayScreen extends StatelessWidget {
  bool visible;
  SavingOverlayScreen({Key? key,required this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          LinearProgressIndicator(),
          Expanded(
            child: Container(
                color: kBlack.withOpacity(0.5)
            ),
          ),
        ],
      ),
    );
  }
}
