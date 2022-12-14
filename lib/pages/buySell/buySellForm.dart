import 'dart:async';

import 'package:helpzz/globals/colors.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:helpzz/models/user.dart';
import 'package:helpzz/pages/home/homepage.dart';
import 'package:helpzz/services/api.dart';
import 'package:helpzz/widgets/nextButton.dart';
import 'package:flutter/material.dart';
import 'package:helpzz/widgets/savingOverlay.dart';
import 'package:provider/provider.dart';

class BuySellForm extends StatefulWidget {
  static const id = "/buySellForm";
  final String category;
  final String imageString;
  const BuySellForm(
      {Key? key,
        required this.category,
        required this.imageString})
      : super(key: key);

  @override
  State<BuySellForm> createState() => _BuySellFormState();
}

class _BuySellFormState extends State<BuySellForm> {
  final formKey = GlobalKey<FormState>();
  var title;
  var description;
  var contactnumber;
  var price;
  bool savingToDB = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (!savingToDB) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.chevron_left_sharp),
        ),
        backgroundColor: kBlueGrey,
        title: Text(
            "2. Details",
          style: MyFonts.w600.size(16).setColor(kWhite),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 15, right: 5, bottom: 15),
                      child: Text(
                        "Fill in the details of ${widget.category == "Buy" ? "Requested Item" : widget.category == "Sell" ? "Selling Item" : widget.category == "Lost" ? "lost object" : "found object"}",
                        style: MyFonts.w400.size(16).setColor(kWhite),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: TextFormField(
                        style: MyFonts.w500.size(15).setColor(kWhite),
                        onChanged: (value){
                          title=value.trim();
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter title of item',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          fillColor: kAppBarGrey,
                          filled: true,
                          hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                          counterStyle: MyFonts.w500.size(12).setColor(kWhite),
                        ),
                        maxLength: 20,
                        validator: (value){
                          if (value == null) {
                            return 'Field cannot be empty';
                          }
                          value=value.trim();
                          if(value.isEmpty){
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: TextFormField(
                        style: MyFonts.w500.size(15).setColor(kWhite),
                        onChanged: (value){
                          description=value.trim();
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter a description',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          fillColor: kAppBarGrey,
                          filled: true,
                          hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                          counterStyle: MyFonts.w500.size(12).setColor(kWhite),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        maxLength: 100,
                        validator: (value){
                          if (value == null) {
                            return 'Field cannot be empty';
                          }
                          value=value.trim();
                          if(value.isEmpty){
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: TextFormField(
                        style: MyFonts.w500.size(15).setColor(kWhite),
                        onChanged: (value){
                          contactnumber=value.trim();
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your contact number',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          fillColor: kAppBarGrey,
                          filled: true,
                          hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                          counterStyle: MyFonts.w500.size(12).setColor(kWhite),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        validator: (value){
                          if (value == null) {
                            return 'Field cannot be empty';
                          }
                          value=value.trim();
                          if(value.isEmpty){
                            return 'Field cannot be empty';
                          }
                          if(value.length<10){
                            return 'length should be 10';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      child: TextFormField(
                        style: MyFonts.w500.size(15).setColor(kWhite),
                        onChanged: (value){
                          price=value.trim();
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter expected price',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          fillColor: kAppBarGrey,
                          filled: true,
                          hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                          counterStyle: MyFonts.w500.size(12).setColor(kWhite),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if (value == null) {
                            return 'Field cannot be empty';
                          }
                          value=value.trim();
                          if(value.isEmpty){
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: GestureDetector(
              onTap: () async {
                bool isValid = formKey.currentState!.validate();
                if (!isValid) {
                  return;
                }
                // setState(() {
                //   isLoading = true;
                // });

                if (savingToDB == true) return;
                setState(() {
                  savingToDB = true;
                });

                var responseBody = await APIService.postItem(widget.category,title, price, description, contactnumber, widget.imageString, context.read<User>().name, context.read<User>().name);
                FocusScope.of(context).requestFocus(FocusNode());
                if (!mounted) return;
                if (responseBody["saved_successfully"] == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Saved data successfully",
                        style: MyFonts.w500,
                      )));
                  Navigator.pop(context,true);
                } else {
                  // savingToDB = false;
                  setState(() {
                    savingToDB=false;
                    // isLoading = false;
                  });
                  if (responseBody["image_safe"] == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "The chosen image is not safe for work !!",
                          style: MyFonts.w500,
                        )));
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Some error occured, please try again",
                        style: MyFonts.w500,
                      )));
                }
              },
              child: NextButton(title: savingToDB == true ? "Saving..." : "Submit",)
              // StreamBuilder(
              //   stream: dbSavingController.stream,
              //   builder: (context, AsyncSnapshot snapshot) {
              //     if (snapshot.hasData && snapshot.data == true) {
              //       return const NextButton(title: "Saving...");
              //     }
              //     return const NextButton(title: "Submit");
              //   },
              // ),
            ),
          ),
          SavingOverlayScreen(visible: savingToDB)
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:
    );
  }
}