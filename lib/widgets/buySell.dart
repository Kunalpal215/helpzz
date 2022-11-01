import 'package:flutter/material.dart';
import 'package:helpzz/globals/colors.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
class BuySellTile extends StatelessWidget {
  final BuySellModel;
  const BuySellTile({Key? key,required this.BuySellModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Duration passedDuration = DateTime.now().difference(BuySellModel.date);
    String timeagoString = timeago.format(DateTime.now().subtract(passedDuration));

    void detailsDialogBox(String imageURL, String description, String contactnumber,DateTime date,String email) {
      showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21),),
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: kBlueGrey,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenHeight*0.7),
            child: Container(
              decoration: BoxDecoration(
                  color: kBlueGrey,
                  borderRadius: BorderRadius.circular(21)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(21),topRight: Radius.circular(21)),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: screenHeight*0.3,maxWidth: screenWidth-30),
                      child: SingleChildScrollView(
                        child: FadeInImage(width: screenWidth-30,placeholder: AssetImage("assets/images/loading.gif"), image: NetworkImage(imageURL),fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 8,top: 10,bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            BuySellModel.title,
                            style: MyFonts.w600.size(16).setColor(kWhite),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: kGrey9,
                                borderRadius: BorderRadius.circular(24)
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Icon(Icons.phone,size: 11,color: lBlue2,),
                                Text(
                                  " +91$contactnumber",
                                  style: MyFonts.w500.size(11).setColor(lBlue2),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: screenHeight*0.2,maxWidth: screenWidth-40),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                        child: Text(
                          "Description: " + description,
                          style: MyFonts.w400.size(14).setColor(kGrey10),
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.2,
                        maxWidth: screenWidth - 40),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          "Posted By: " + email,
                          style: MyFonts.w300.size(14).setColor(kGrey10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16,bottom: 16),
                    alignment: Alignment.centerRight,
                    child: Text(
                      date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString() + " | " + DateFormat.jm().format(date.toLocal()).toString(),
                      style: MyFonts.w400.size(13).setColor(kGrey7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }

    return GestureDetector(
      onTap: (){
        detailsDialogBox(BuySellModel.imageURL, BuySellModel.description, BuySellModel.phonenumber,BuySellModel.date,BuySellModel.email);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
        decoration: BoxDecoration(
            color: kBlueGrey,
            borderRadius: BorderRadius.circular(21)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 194),
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16,),
                      child: Text(
                        BuySellModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MyFonts.w500.size(16).setColor(kWhite),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Price: \u{20B9}${BuySellModel.price}/-',
                        style: MyFonts.w600.size(14).setColor(lBlue4),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 13,vertical: 6),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: kGrey9,
                          borderRadius: BorderRadius.circular(41)
                      ),
                      child: Text(
                        timeagoString,
                        style: MyFonts.w500.size(12).setColor(lBlue2),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 105,maxWidth: 135),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(21),bottomRight: Radius.circular(21)),
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth*0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(BuySellModel.compressedImageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

