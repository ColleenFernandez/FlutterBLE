import 'dart:io';

import 'package:fble/Assets/Assets.dart';
import 'package:flutter/material.dart';

class StsImgView extends StatefulWidget{

  static final int LOCAL_IMG = 102;

  late dynamic image;
  late double width;
  late double height;


  StsImgView({required this.image, required this.width, required this.height});

  @override
  _StsImgViewState createState() => _StsImgViewState();
}

class _StsImgViewState extends State<StsImgView> {
  @override
  Widget build(BuildContext context) {

    double width = widget.width;
    double height = widget.height;

    if (widget.image is File) {

      final imgFile = widget.image as File;

      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image.file(File(imgFile.path), width: width, height: height, fit: BoxFit.cover,)
      );
    }


    final AssetImage image = widget.image as AssetImage;
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Image(
            image: image,
            width: width,
            height: height, fit: BoxFit.cover));
  }
}