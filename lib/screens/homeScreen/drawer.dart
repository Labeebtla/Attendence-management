// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      Container(
        height: 120,
        color: Colors.amber,
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed('/subjects');
        },
        child: ListTile(
          leading: IconButton(
            icon: const Icon(Icons.subject),
            onPressed: () {
              Get.toNamed('/subjects');
            },
          ),
          title: Text('subject'),
        ),
      ),
      GestureDetector(
        onTap: () => Get.toNamed('/timetable'),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              Get.toNamed('/timetable');
            },
          ),
          title: Text('Timetable'),
        ),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.history),
          onPressed: () {},
        ),
        title: Text('History'),
      ),
      GestureDetector(
        onTap: () => Get.toNamed('/criteria'),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.edit_document),
            onPressed: () {
              Get.toNamed('/criteria');
            },
          ),
          title: Text('Edit Attendence'),
        ),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.restore),
          onPressed: () {},
        ),
        title: Text('Backup & Restore'),
      ),
      GestureDetector(
        onTap: () => Get.toNamed('/setting'),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/setting');
            },
          ),
          title: Text('Settings  '),
        ),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () {},
        ),
        title: Text('How To USe'),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.bug_report),
          onPressed: () {},
        ),
        title: Text('Report Bug'),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.comment),
          onPressed: () {},
        ),
        title: Text('Suggestions'),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.rate_review),
          onPressed: () {},
        ),
        title: Text('Rate App'),
      ),
      ListTile(
        leading: IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        title: Text('Share App'),
      )
    ]));
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu), // Replace 'custom_icon' with the icon you want
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      color: Colors.white, // Set the color here
    );
  }
}
