import 'dart:convert';

import 'package:alquran/app/contants/thema.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<Surah> allSurah = [];
  RxBool isDark = false.obs;

  void changeThemeMode() async {
    Get.isDarkMode ? Get.changeTheme(themaLight) : Get.changeTheme(themaDark);
    isDark.toggle();

    final box = GetStorage();

    if (Get.isDarkMode) {
      // dark -> light
      box.remove("themaDark");
    } else {
      // light -> dark
      box.write("themaDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data.isEmpty) {
      //(data == null || data.isEmpty)
      // menampilkan list kosong
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah; // mengambil/map list data surah <Surah> dan akan menampilkan data tersebut ke body/ui
    }
  }

  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;

    List<Map<String, dynamic>> penampungAyat = [];
    List<Map<String, dynamic>> allJuz = [];

    for (var i = 1; i <= 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));
      Map<String, dynamic> rawData = json.decode(res.body)["data"];
      DetailSurah data = DetailSurah.fromJson(rawData);

      if (data.verses != null) {
        data.verses!.forEach((ayat) {
          if (ayat.meta?.juz == juz) {
            penampungAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          } else {
            allJuz.add({
              "juz": juz,
              "start": penampungAyat[0],
              "end": penampungAyat[penampungAyat.length - 1],
              "verses": penampungAyat,
            });
            juz++;
            penampungAyat = [];
            penampungAyat.add({
              "surah": data,
              "ayat": ayat,
            });
          }
        });
      }
    }
    allJuz.add({
      "juz": juz,
      "start": penampungAyat[0],
      "end": penampungAyat[penampungAyat.length - 1],
      "verses": penampungAyat,
    });
    return allJuz;
  }
}
