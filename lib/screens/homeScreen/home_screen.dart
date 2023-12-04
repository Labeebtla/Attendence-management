// ignore_for_file: camel_case_types

import 'package:attendence_manager/controller/controller.dart';
import 'package:attendence_manager/model/model.dart';
import 'package:attendence_manager/model/table_model.dart';
import 'package:attendence_manager/screens/subject/addSubject.dart';
import 'package:attendence_manager/criteria/criteria.dart';
import 'package:attendence_manager/screens/homeScreen/button.dart';
import 'package:attendence_manager/screens/homeScreen/drawer.dart';
import 'package:attendence_manager/screens/loginScreen/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final Color color = Colors.white;
  final DetailsController detailsController = Get.put(DetailsController());
  final DetailsController criteriaController = Get.put(DetailsController());
  final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tableBox = Hive.box<TableModel>('tablebox');
    // Retrieve classes from Hive
    // ignore: unused_local_variable
    final List<TableModel> table = tableBox.values.toList();
    DateTime now = DateTime.now();
    String month = DateFormat('MMMM', 'en_us').format(now);
    String year = DateFormat('yyyy', 'en_us').format(now);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      drawer: const drawer(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  month,
                  style: TextStyle(
                      fontSize: 16, color: color, fontWeight: FontWeight.bold),
                ),
                Text(
                  year,
                  style: TextStyle(
                      fontSize: 12, color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: circleDate(date: now.day.toString()),
            ),
          ]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                signout(context);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(.0),
            child: TextButton(
                onPressed: () {
                  signout(context);
                },
                child: Text(
                  'sign out',
                  style: TextStyle(
                      fontSize: 18, color: color, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: color,
                )),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.amber[50],
              expandedHeight: 220.0,
              pinned: false,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 35,
                            child: Obx(
                              () => textButtonwithicon(
                                  pressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx1) =>
                                                const criteria()));
                                  },
                                  colorblack: Colors.black,
                                  icon: Icons.flag,
                                  text:
                                      'Goal ${criteriaController.savedCriteria}% '),
                            )),
                        Row(
                          children: [
                            textButtonwithicon(
                                pressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const criteria()));
                                },
                                colorblack: Colors.black,
                                icon: Icons.check_circle,
                                text: 'Overall Attendence'),
                            const SizedBox(
                              width: 95,
                              height: 40,
                            ),
                            CircularPercentIndicator(
                              radius: 30,
                              lineWidth: 5,
                              backgroundWidth: -1,
                              progressColor: Colors.amber,
                              percent: .4,
                              center: Obx(
                                () => CircularPercentIndicator(
                                  radius: 20,
                                  lineWidth: 5,
                                  progressColor:
                                      const Color.fromARGB(255, 234, 207, 125),
                                  backgroundColor:
                                      const Color.fromARGB(255, 188, 184, 170),
                                  percent: double.parse(criteriaController
                                          .savedCriteria.value) /
                                      100,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            iconButton(
                                backgroundcolor: Colors.green,
                                colorwhite: color,
                                icon: Icons.bar_chart),
                            iconButton(
                                backgroundcolor: Colors.blue,
                                colorwhite: color,
                                icon: Icons.timeline_rounded),
                            IconButton(
                              onPressed: () {
                                Get.toNamed('/timetable');
                              },
                              icon: const Icon(Icons.calendar_month_rounded),
                              color: color,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                            ),
                            iconButton(
                                backgroundcolor: Colors.red,
                                colorwhite: color,
                                icon: Icons.settings),
                            const SizedBox(
                              width: 40,
                            ),
                            Button(
                              text: 'ADD SUBJECT',
                              onpressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => addSubject()));
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 280,
                              height: 40,
                              child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: TabBar(
                                      unselectedLabelColor: Colors.black,
                                      labelColor: Colors.black,
                                      controller: tabController,
                                      splashBorderRadius:
                                          BorderRadius.circular(70),
                                      indicator: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: color,
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3)),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          color: Colors.amber),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: const [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Tab(
                                            text: ' All Subject ',
                                          ),
                                        ),
                                        Tab(
                                          text: 'Time Table Mode',
                                        )
                                      ])),
                            ),
                            // Container(
                            //   width: 100,
                            //   child: textButtonwithicon(
                            //       colorblack: Colors.black26,
                            //       icon: Icons.add,
                            //       text: 'Extra class'),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            Obx(
              () => ListView.builder(
                itemCount: detailsController.details.length,
                itemBuilder: (BuildContext context, int index) {
                  SubjectModel subjectmodel = detailsController.details[index];
                  final model = subjectmodelbox.get(index);

                  final present = int.parse(model!.present);
                  final total = int.parse(model.total);
                  final percent = present / total;
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${subjectmodel.subject}'
                                    '',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Row(
                                    children: [
                                      const Text('Attendence'),
                                      Text(
                                        ' ${subjectmodel.present}'
                                        '',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        '/${subjectmodel.total}',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text('Status:'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  CircularPercentIndicator(
                                      radius: 25,
                                      lineWidth: 5,
                                      backgroundWidth: -1,
                                      progressColor: Colors.amber,
                                      percent: percent),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: IconButton.filled(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.check_rounded,
                                            color: color,
                                            size: 20,
                                          ),
                                          style: IconButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          iconSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          // iconSize: 12,

                                          icon: Icon(
                                            Icons.disabled_by_default_rounded,
                                            color: color,
                                          ),

                                          style: IconButton.styleFrom(
                                              backgroundColor: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class circleDate extends StatelessWidget {
  final String date;
  const circleDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(20.0)),
      child: Center(
        child: Text(
          date,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

signout(BuildContext ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => const loginScreen()),
      (route) => false);
}
