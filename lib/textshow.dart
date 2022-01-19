import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/main.dart';

class TextShow extends StatefulWidget {
  const TextShow({Key? key}) : super(key: key);

  @override
  _TextShowState createState() => _TextShowState();
}

class _TextShowState extends State<TextShow> {
  File? image;
  final picker = ImagePicker();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0f725f),
        title: const Text(
          "Image Text Recognition",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              image == null
                  ? const Text("Resim Seçiniz")
                  : Image.file(
                      image!,
                      height: 400,
                      width: 400,
                    ),
              const SizedBox(
                height: 15,
              ),
              FloatingActionButton.extended(
                label: const Text("Galeri"),
                icon: const Icon(Icons.photo_library),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                backgroundColor: Color(0xff0f725f),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Galeriden resmi al, alınan resmi pickedFile aktar. resim yolunu image dosyasına yaz
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);

      performImageLabeling();
    });
  }

  //GoogleMlVision
  performImageLabeling() async {
    final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(image!);

    final TextRecognizer recognizer = GoogleVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(visionImage);

    result = "";

    setState(() {
      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            result += (element.text! + " ");
          }
        }
        result += "\n";
      }
    });
  }
}
