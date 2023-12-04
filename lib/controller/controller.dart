import 'package:attendence_manager/model/model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DetailsController extends GetxController {
  // ignore: unused_field
  RxString subject = ''.obs;
  RxString present = ''.obs;
  RxString total = ''.obs;

  RxList<SubjectModel> details = <SubjectModel>[].obs;

  // var savedDetails = [].obs;
  var savedCriteria = '0'.obs;
  @override
  void onInit() {
    super.onInit();
    subjectDetails(); //from hive during controller initialization
  }

  void subjectDetails() {
    final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
    details.assignAll(subjectmodelbox.values.cast<SubjectModel>());
  }

  void updateDetail(String nsubject, String npresent, String ntotal) {
    subject.value = nsubject;
    present.value = npresent;
    total.value = ntotal;
  }

  void addDetail() {
    final subjectmodel = SubjectModel(
        subject: subject.value, present: present.value, total: total.value);
    details.add(subjectmodel);

    //save to hive
    final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
    subjectmodelbox.add(subjectmodel);
  }

  //save th detail after the delete
  void saveDetails() async {
    final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
    await subjectmodelbox.clear();
    await subjectmodelbox.addAll(details);
  }

  void deleteDetails(int index) {
    details.removeAt(index);
    saveDetails();
  }

  void clearAll() {
    final subjectmodelbox = Hive.box<SubjectModel>('subjectmodelbox');
    subjectmodelbox.clear();
    details.clear();
  }
}

class ThemeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.light.obs;

  void toggleTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
