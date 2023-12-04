// ignore_for_file: camel_case_types

import 'package:attendence_manager/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class criteria extends StatefulWidget {
  const criteria({super.key});

  @override
  State<criteria> createState() => _criteriaState();
}

class _criteriaState extends State<criteria> {
  final DetailsController criteriaController = Get.put(DetailsController());
  double currentValue = 0;

  double percentValue = 0;

  @override
  Widget build(BuildContext context) {
    currentValue = double.parse(criteriaController.savedCriteria.value);
    percentValue = double.parse(criteriaController.savedCriteria.value) / 100;

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(35.0),
                  child: Text(
                    'Set Attendence Criteria',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularPercentIndicator(
                    radius: 50,
                    lineWidth: 15,
                    progressColor: Colors.amber,
                    backgroundColor: const Color.fromARGB(255, 188, 184, 170),
                    percent: percentValue,
                    // percent:
                    //     double.parse(criteriaController.savedCriteria.value) /
                    // 100,
                    center: Text(
                      ' ${currentValue.toStringAsFixed(0)}%',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Slider(
                      activeColor: Colors.amber,
                      value: currentValue,
                      // value:
                      //     double.parse(criteriaController.savedCriteria.value),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                          percentValue = value / 100;
                          criteriaController.savedCriteria.value =
                              currentValue.toStringAsFixed(0);
                        });
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    child: const Text(
                      'save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
