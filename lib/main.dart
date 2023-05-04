import 'package:color_pallate_generator_app/screens/random_color.dart';
import 'package:cyclop/cyclop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'screens/collaction.dart';
import 'screens/image_color.dart';
import 'screens/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Image_Colors(),
    ColorGenerator(),
     //SecondPage(
     //  colors: [],
     // colors1: [],
     // colors2: [],
     // ),
    UserInformation(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return EyeDrop(
      child: MaterialApp(
        // routes: {
        //   'Collection': (context) => SecondPage(
        //         colors: [],
        //     //    colors1: [],
        //     //    colors2: [],
        //       ),
        // },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: const Duration(milliseconds: 400),
            backgroundColor: Colors.grey.shade200,
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.auto_awesome, size: 30),
              Icon(Icons.color_lens, size: 30),
              Icon(Icons.settings, size: 30),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
