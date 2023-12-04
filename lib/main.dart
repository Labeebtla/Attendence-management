// ignore_for_file: prefer_const_constructors

import 'package:attendence_manager/model/model.dart';
import 'package:attendence_manager/model/table_model.dart';
import 'package:attendence_manager/screens/settings.dart';
import 'package:attendence_manager/screens/subject/addSubject.dart';
import 'package:attendence_manager/criteria/criteria.dart';
import 'package:attendence_manager/screens/homeScreen/home_screen.dart';
import 'package:attendence_manager/screens/loginScreen/login_screen.dart';
import 'package:attendence_manager/screens/timeTable/addClass.dart';
import 'package:attendence_manager/screens/timeTable/timetable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SubjectModelAdapter().typeId)) {
    Hive.registerAdapter(SubjectModelAdapter());
  }
  if (Hive.isAdapterRegistered(TableModelAdapter().typeId)) {
    Hive.isAdapterRegistered(TableModelAdapter().typeId);
  }
  await Hive.openBox<SubjectModel>('subjectmodelbox');
  await Hive.openBox<TableModel>('tablebox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginScreen': (context) => loginScreen(),
        '/homeScreen': (context) => homeScreen(),
        '/criteria': (context) => criteria(),
        '/subjects': (context) => addSubject(),
        '/timetable': (context) => timeTable(),
        '/add class': (context) => addClass(),
        '/setting': (context) => setting()
      },
      initialRoute: '/loginScreen',
    );
  }
}
