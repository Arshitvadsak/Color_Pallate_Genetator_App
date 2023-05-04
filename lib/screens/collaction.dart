// // Second page
// import 'package:flutter/material.dart';

// class SecondPage extends StatelessWidget {
//   final List<Color> colors;

//   SecondPage({required this.colors});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 5,
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//             childAspectRatio: 1.5,
//           ),
//           itemCount: colors.length,
//           itemBuilder: (context, index) {
//             return Container(
//               color: colors[index],
//               child: Center(
//                 child: Text(
//                   colors[index].value.toRadixString(16),
//                   style:const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_color/random_color.dart';
import 'firebase/firebasehelper.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('colors').snapshots();
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
      backgroundColor:  (Get.isDarkMode) ? Colors.black : Colors.white ,
      appBar: AppBar(
        title:  Text(
          'Collection',
          style: TextStyle(
            color: (Get.isDarkMode) ? Colors.white : Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return Column(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  print('==============================');
                  print(data.values);
                  print('==============================');
                  return Container(
                    height: 70,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 2,
                              childAspectRatio: 5 / 1),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final entry = data.entries.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Container(
                                width: 230,
                                decoration: BoxDecoration(
                                  color: Color(0xff6C9BCF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${entry.key}: ${entry.value}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  deleteAllDocuments();
                                },
                                child: Text("z"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
