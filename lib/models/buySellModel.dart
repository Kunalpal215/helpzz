import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BuySellModel {
  final String title;
  final String description;
  final String imageURL;
  final String compressedImageURL;
  final String phonenumber;
  final String price;
  final DateTime date;
  final String username;
  final String email;

  const BuySellModel(
      {Key? key,
        required this.title,
        required this.description,
        required this.imageURL,
        required this.compressedImageURL,
        required this.date,
        required this.phonenumber,
        required this.price,
        required this.email,
        required this.username});

}