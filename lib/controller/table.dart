import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableController extends GetxController {
  var selected = ''.obs;
  var time = TimeOfDay.now().obs;
  var length = 0.0.obs;
  var location = TextEditingController().obs;
  var formEntry = <String>[].obs;
}
