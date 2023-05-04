import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'collaction.dart';
import 'firebase/firebasehelper.dart';

class ColorGenerator extends StatefulWidget {
  @override
  _ColorGeneratorState createState() => _ColorGeneratorState();
}

class _ColorGeneratorState extends State<ColorGenerator> {
  List<Color> _colors = [];

  void _generateColors() {
    setState(() {
      _colors.clear();
      final random = Random();
      final randomColor = RandomColor();
      for (int i = 0; i < 5; i++) {
        _colors.add(randomColor.randomColor(
          colorBrightness: ColorBrightness.light,
          colorSaturation: ColorSaturation.highSaturation,
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _generateColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palette Generator'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, crossAxisSpacing: 2, childAspectRatio: 5 / 1
            // mainAxisSpacing: 2,
            ),
        itemCount: _colors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: _colors[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${_colors[index]}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _generateColors,
            child: Icon(Icons.refresh),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              await saveColors(_colors);
            //  Navigator.push(
            //    context,
            //    MaterialPageRoute(
            //      builder: (context) => 
            //       SecondPage(
            //         colors: _colors,
            //         //colors2: [],
            //         //colors1: [],
            //       ),
            //     ),
            //  );
            },
            child: Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
