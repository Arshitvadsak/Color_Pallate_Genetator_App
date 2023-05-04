import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cyclop/cyclop.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'collaction.dart';
import 'firebase/firebasehelper.dart';

class Image_Colors extends StatefulWidget {
  const Image_Colors({Key? key}) : super(key: key);

  @override
  Image_ColorsState createState() => Image_ColorsState();
}

class Image_ColorsState extends State<Image_Colors> {
  Color appbarColor = Colors.blueGrey;
  Color backgroundColor = Colors.grey.shade200;
  Set<Color> swatches = Colors.primaries.map((e) => Color(e.value)).toSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Get.isDarkMode) ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Color Picker',
            style: TextStyle(
              color: (Get.isDarkMode) ? Colors.white : Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Column(
                children: [
                  Center(
                    child: _image == null
                        ? GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: Colors.black45,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.photo,
                                        size: 50, color: Colors.black),
                                    Text(
                                      "Tap to select Image",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width / 1.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      color: Colors.black45,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _pickImage();
                                },
                                icon: Icon(Icons.photo),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EyedropperButton(
                        icon: Icons.colorize,
                        iconColor:
                            (Get.isDarkMode) ? Colors.white : Colors.black,
                        onColor: _handleColorPicked,
                      ),
                      for (final color in _colorPalette)
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _selectedColor = color;
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await saveColors(_colorPalette);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SecondPage(
          //       colors: _colorPalette,
          //       // colors2: [],
          //     ),
          //   ),
          // );
        },
        child: Icon(Icons.save),
      ),
    );
  }

  final List<Color> _colorPalette = [];
  Color? _selectedColor;

  void _handleColorPicked(Color color) {
    if (_colorPalette.length < 5) {
      setState(() {
        _selectedColor = color;
        _colorPalette.add(color);
      });
    }
  }

  File? _image;
  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }
}
