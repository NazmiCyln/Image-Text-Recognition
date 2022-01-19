import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocr/textshow.dart';


void main() {
  runApp(const Ocr());
}

class Ocr extends StatelessWidget {
  const Ocr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextShow(),
    );
  }
}



