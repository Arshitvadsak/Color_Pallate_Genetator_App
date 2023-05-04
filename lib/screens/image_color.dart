import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cyclop/cyclop.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final bodyTextColor =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? Colors.white70
            : Colors.black87;
    final appbarTextColor =
        ThemeData.estimateBrightnessForColor(appbarColor) == Brightness.dark
            ? Colors.white70
            : Colors.black87;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Color Pallate',
          style: textTheme.titleLarge?.copyWith(color: appbarTextColor),
        ),
        backgroundColor: appbarColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: ColorButton(
                darkMode: true,
                color: appbarColor,
                boxShape: BoxShape.rectangle,
                swatches: swatches,
                size: 32,
                config: const ColorPickerConfig(
                  enableOpacity: false,
                  enableLibrary: false,
                ),
                onColorChanged: (value) => setState(
                  () => appbarColor = value,
                ),
                onSwatchesChanged: (newSwatches) => setState(
                  () => swatches = newSwatches,
                ),
              ),
            ),
          )
        ],
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
                                    Icon(
                                      Icons.photo,
                                      size: 50,
                                    ),
                                    Text(
                                      "Tap to select Image",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EyedropperButton(
                        icon: Icons.colorize,
                        onColor: _handleColorPicked1,
                      ),
                      for (final color in _colorPalette1)
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _selectedColor1 = color;
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
                  Text(
                    "$_colorPalette",
                  ),
                  Text("$_colorPalette1")
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await saveColors(_colorPalette);
          // Navigator.push(
          //   context,
            // MaterialPageRoute(
            //   builder: (context) => SecondPage(
            //     colors: _colorPalette,
            //     colors1: _colorPalette1, 
            //     colors2: [],
            //   ),
            // ),
        //  );
        },
        child: Icon(Icons.save),
      ),
    );
  }

  final List<Color> _colorPalette = [];
  Color? _selectedColor;
  final List<Color> _colorPalette1 = [];
  Color? _selectedColor1;

  void _handleColorPicked(Color color) {
    if (_colorPalette.length < 5) {
      setState(() {
        _selectedColor = color;
        _colorPalette.add(color);
      });
    }
  }

  void _handleColorPicked1(Color color) {
    if (_colorPalette1.length < 5) {
      setState(() {
        _selectedColor1 = color;
        _colorPalette1.add(color);
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
