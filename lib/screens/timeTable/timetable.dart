// ignore_for_file: camel_case_types

import 'package:attendence_manager/screens/homeScreen/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class timeTable extends StatefulWidget {
  const timeTable({super.key});

  @override
  State<timeTable> createState() => _timeTableState();
}

class _timeTableState extends State<timeTable>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final Color color = Colors.white;

  @override
  void initState() {
    tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeTable'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        height: 30,
        color: Colors.black,
        child: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.black,
            controller: tabController,
            splashBorderRadius: BorderRadius.circular(70),
            indicator: BoxDecoration(boxShadow: const [
              BoxShadow(
                  // color: color,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3)),
            ], borderRadius: BorderRadius.circular(70), color: Colors.amber),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: 'monday',
              ),
              Tab(
                text: 'tuesday',
              ),
              Tab(
                text: 'wednesday',
              ),
              Tab(
                text: 'thursday',
              ),
              Tab(
                text: 'friday',
              ),
              Tab(
                text: 'saturday',
              ),
              Tab(
                text: 'sunday',
              ),
            ]),
      ),
      bottomSheet: SizedBox(
          width: 500,
          child: Button(
              text: 'Add Class',
              onpressed: () {
                Get.toNamed('/add class');
              })),
    );
  }
}
