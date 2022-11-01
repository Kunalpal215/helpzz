import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpzz/globals/colors.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:helpzz/models/buySellModel.dart';
import 'package:helpzz/pages/buySell/buySellForm.dart';
import 'package:helpzz/services/api.dart';
import 'package:helpzz/widgets/appbar.dart';
import 'package:helpzz/widgets/buySell.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
  static const id = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController selectedTypeController = StreamController();
  String category="Buy";
  List<Widget> buyItems=[];
  List<Widget> sellItems=[];
  bool loading1 = true;
  bool loading2 = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading1=true;
      loading2=true;
    });
    buyItems.clear();
    sellItems.clear();
    APIService.getBuyItems().then((data){
      data.forEach((element) => {
        buyItems.add(BuySellTile(BuySellModel: BuySellModel(title: element["title"], description: element["description"], imageURL: element["imageURL"], compressedImageURL: element["compressedImageURL"], date: DateTime.parse(element["date"]), phonenumber: element["phonenumber"], price: element["price"], email: element["email"], username: element["username"])))
      });
      setState(() {
        loading1=false;
      });
    });
    APIService.getSellItems().then((data){
      data.forEach((element) => {
        sellItems.add(BuySellTile(BuySellModel: BuySellModel(title: element["title"], description: element["description"], imageURL: element["imageURL"], compressedImageURL: element["compressedImageURL"], date: DateTime.parse(element["date"]), phonenumber: element["phonenumber"], price: element["price"], email: element["email"], username: element["username"])))
      });
      setState(() {
        loading2=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    Stream typeStream = selectedTypeController.stream.asBroadcastStream();
    return Scaffold(
      appBar: appBar(screenwidth),
      body: (!loading1 && !loading2) ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    if(category=="Sell"){
                      setState(() {
                        category="Buy";
                      });
                    }
                  },
                  child: ItemTypeBar(text: "Buy", margin: EdgeInsets.only(left: 16,bottom: 10) ,textStyle: MyFonts.w500.size(14).setColor(category=="Buy" ? kBlack : kWhite),backgroundColor: category=="Buy" ? lBlue2 : kBlueGrey),
                ),
                GestureDetector(
                  onTap: (){
                    if(category=="Buy"){
                      setState(() {
                        category="Sell";
                      });
                    }
                  },
                  child: ItemTypeBar(text: "Sell", margin: EdgeInsets.only(left: 16,bottom: 10) ,textStyle: MyFonts.w500.size(14).setColor(category=="Sell" ? kBlack : kWhite),backgroundColor: category=="Sell" ? lBlue2 : kBlueGrey),
                )
              ],
            ),
          ),
          category=="Buy" ? (buyItems.isEmpty ? Center(child: Text("No Buy Items as of now :)", style: MyFonts.w500.size(16).setColor(kWhite),),) : Expanded(child: ListView(children: buyItems,))) : (sellItems.isEmpty ? Center(child: Text("No Sell Items as of now :)", style: MyFonts.w500.size(16).setColor(kWhite),),) : Expanded(child: ListView(children: sellItems,)))
        ],
      ) : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          XFile? xFile;
          await showDialog(
              context: context,
              builder: (BuildContext dialogContext){
                return AlertDialog(
                    title: Text("From where do you want to take the photo?"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: Text("Gallery"),
                            onTap: () async {
                              xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            child: Text("Camera"),
                            onTap: () async {
                              xFile = await ImagePicker().pickImage(source: ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ));
              });
          if(xFile!=null){
            var bytes = File(xFile!.path).readAsBytesSync();
            var imageSize = (bytes.lengthInBytes/(1048576)); // dividing by 1024*1024
            if(imageSize>2.5){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Maximum image size can be 2.5 MB")));
              return;
            }
            var imageString = base64Encode(bytes);
            print(imageString);
            bool res = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BuySellForm(
                  category: category,
                  imageString: imageString,
                )));
            if(res==true){
              fetchData();
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: lBlue2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20),
                child: Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18,left: 16,right: 20,bottom: 18),
                child: Text(
                  category=="Buy" ? "Buy Item" : "Sell item",
                  style: MyFonts.w800.size(14).setColor(kBlack),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ItemTypeBar extends StatelessWidget {
  final text;
  TextStyle textStyle;
  Color backgroundColor;
  EdgeInsets margin;
  ItemTypeBar({Key? key, required this.text, required this.textStyle,required this.backgroundColor,required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}