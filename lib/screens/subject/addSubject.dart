// ignore_for_file: camel_case_types, file_names

import 'package:attendence_manager/controller/controller.dart';

import 'package:attendence_manager/model/model.dart';
import 'package:attendence_manager/screens/homeScreen/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addSubject extends StatelessWidget {
  addSubject({super.key});
  final DetailsController detailsController = Get.put(DetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            'Subjects',
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: detailsController.details.length,
                    itemBuilder: (context, index) {
                      SubjectModel subjectmodel =
                          detailsController.details[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(subjectmodel.subject),
                                Row(
                                  children: [
                                    Text('present: ${subjectmodel.present}'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('Total class: ${subjectmodel.total}'),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const iconButton(
                                        backgroundcolor: Colors.white,
                                        colorwhite: Colors.black45,
                                        icon: Icons.edit),
                                    const iconButton(
                                        backgroundcolor: Colors.white,
                                        colorwhite: Colors.black45,
                                        icon: Icons.restore),
                                    IconButton(
                                        onPressed: () {
                                          detailsController
                                              .deleteDetails(index);
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
        ],
      ),
      bottomSheet: SizedBox(
          width: 500,
          child: Button(
              text: 'Add Subject',
              onpressed: () {
                showCategoryAddPopup(context);
              })),
    );
  }
}

Future<void> showCategoryAddPopup(BuildContext context) async {
  // final nameEditingController = TextEditingController();
  // final presentController = TextEditingController();
  // final totalPresentController = TextEditingController();
  final DetailsController detailsController = Get.find<DetailsController>();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
          title: const Text(
            'Add Transactions',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => detailsController.updateDetail(
                        value,
                        detailsController.present.value,
                        detailsController.total.value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Subject',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => detailsController.updateDetail(
                        detailsController.subject.value,
                        value,
                        detailsController.total.value),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'initial present',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => detailsController.updateDetail(
                        detailsController.subject.value,
                        detailsController.present.value,
                        value),
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'initial total present',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Button(
                              text: 'cancel',
                              onpressed: () {
                                Get.back();
                              })),
                      Expanded(
                          child: Button(
                              text: 'save',
                              onpressed: () {
                                int total = int.tryParse(
                                        detailsController.total.value) ??
                                    0;
                                int present = int.tryParse(
                                        detailsController.present.value) ??
                                    0;

                                if (total > present) {
                                  // Save details
                                  detailsController.addDetail();
                                  Get.back();
                                } else {
                                  // Show an error message
                                  Get.snackbar(
                                    'Sorry',
                                    'Total Class must be greater than present',
                                    backgroundColor: Colors.amber,
                                    colorText: Colors.white,
                                  );
                                }
                              }))
                    ],
                  )
                ],
              ),
            )
          ]);
    },
  );
}
