import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'package:alquran/app/contants/thema.dart';
import '../controllers/introduction_controller.dart';
import 'package:alquran/app/routes/app_pages.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 90,
            ),
            child: Text(
              "Al - Quran Apps",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Learn Al-Quran and \nRecite once everyday",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: kGreyColor,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Container(
              width: 300,
              height: 300,
              child: Lottie.asset(
                "assets/lotties/animasi-quran.json",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(230, 50),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  primary: Get.isDarkMode ? kWhiteColor : kPurpleColor,
                  onPrimary: kPurpleColor,
                ),
                onPressed: () => Get.offAllNamed(
                  Routes.HOME,
                ),
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Get.isDarkMode ? kPurpleColor : kWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
