import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:05 PM
///


class UtkalSnackbar{
  static void show(String title, String message){
    Get.snackbar(

        title, message, snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,maxWidth: 300,
        animationDuration: const Duration(
            milliseconds: 300),
        margin: const EdgeInsets.all(16));
  }
}
