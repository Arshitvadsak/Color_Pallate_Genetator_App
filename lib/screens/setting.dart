import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Setting Page',
          style: TextStyle(
            color: (Get.isDarkMode) ? Colors.white : Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: (Get.isDarkMode) ? Colors.black : Colors.white,
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notifications'),
            subtitle: Text('Enable push notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('Dark Mode'),
            subtitle: Text("Enable dark mode"),
            trailing: Icon(Icons.light),
            onTap: () {
              (Get.isDarkMode)
                  ? Get.changeThemeMode(ThemeMode.light)
                  : Get.changeThemeMode(ThemeMode.dark);
            },
          ),
          ListTile(
            title: Text('Language'),
            subtitle: Text('English'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Help'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //Navigator.of(context).pushNamed('theme');
              // Navigate to help page
            },
          ),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle logout action
            },
          ),
        ],
      ),
    );
  }
}
