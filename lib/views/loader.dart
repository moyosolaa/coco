import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Loader {
  static void showLoader() {
    Get.dialog(
      const Center(
        child: SpinKitFadingCircle(
          size: 48,
          color: Colors.white,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
