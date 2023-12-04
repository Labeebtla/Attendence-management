// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:attendence_manager/controller/controller.dart';
import 'package:attendence_manager/controller/table.dart';
import 'package:attendence_manager/model/model.dart';
import 'package:attendence_manager/model/table_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive/hive.dart';

class addClass extends StatefulWidget {
  const addClass({super.key});

  @override
  State<addClass> createState() => _addClassState();
}

class _addClassState extends State<addClass> {
  final DetailsController detailsController = Get.put(DetailsController());
  final TextEditingController optionalController = TextEditingController();
  final TableController tableController = Get.put(TableController());

  final tablebox = Hive.box<TableModel>('tablebox');
  double lengthvalue = 0;
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 00);
  String selectedOption = ' select subject';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Add Class'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () {
                final tablebox = Hive.box<TableModel>('tablebox');

                tablebox.add(TableModel(
                  selected: tableController.selected.value,
                  time: tableController.time.value.format(context),
                  length: tableController.length.value,
                  location: tableController.length.value.toString(),
                ));

                Get.back();
              },
              icon: const Icon(
                Icons.check_circle,
              ),
              color: Colors.white,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.subject_sharp),
                    style: IconButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  const MyDropdownButton()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.timelapse_rounded),
                    style: IconButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  TextButton(
                      onPressed: () {
                        showTimePicker(
                                context: context,
                                initialTime: tableController.time.value)
                            .then((value) => setState(() {
                                  tableController.time.value = value!;
                                }));
                      },
                      child: Column(
                        children: [
                          const Text(
                            'Start Time',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            " ${tableController.time.value.format(context)}",
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text(
                    'Class Length',
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    '${tableController.length.value}'.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Slider(
                      activeColor: Colors.amber,
                      min: 0,
                      max: 500,
                      value: tableController.length.value,
                      onChanged: ((value) {
                        setState(() {
                          tableController.length.value = value;
                        });
                      }))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                    style: IconButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: tableController.location.value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Location or Room Number (Optional)'),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
  final TableController tableController = Get.put(TableController());
  @override
  void initState() {
    super.initState();
    // Initialize selectedOption with the first value in the list
    tableController.selected.value = 'select subject';
  }

  @override
  Widget build(BuildContext context) {
    List<String> subjects = ['select subject'];
    subjects.addAll(subjectmodelbox.values.map((e) {
      return e.subject;
    }).toList());

    return DropdownButton<String>(
      onChanged: (String? newValue) {
        setState(() {
          tableController.selected.value = newValue!;
          // tableController.selected.value = selectedOption;
          // print('$selectedOption');
        });
      },
      value: tableController.selected.value,
      items: subjects.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
