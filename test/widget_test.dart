import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alquran/app/data/models/detail_surah.dart';

void main() async {
  int juz = 1;

  List<Map<String, dynamic>> penampungAyat = [];
  List<Map<String, dynamic>> allJuz = [];

  for (var i = 1; i <= 114; i++) {
    var res =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));
    Map<String, dynamic> rawData = json.decode(res.body)["data"];
    DetailSurah data = DetailSurah.fromJson(rawData);

    if (data.verses != null) {
      // ex: surah albaqoroh>ratusan ayat
      // juz1>ayat 1-141
      // juz2>ayat 142-..

      data.verses!.forEach((ayat) {
        if (ayat.meta?.juz == juz) {
          penampungAyat.add({
            "surah": data.name?.transliteration?.id ?? '',
            "ayat": ayat,
          });
        } else {
          print("BERHASIL MEMASUKAN JUZ $juz");
          print("START :");
          print(
              "Ayat : ${(penampungAyat[0]["ayat"] as Verse).number?.inSurah}");
          print((penampungAyat[0]["ayat"] as Verse).text?.arab);
          print("END :");
          print(
              "Ayat:${(penampungAyat[penampungAyat.length - 1]["ayat"] as Verse).number?.inSurah}");
          print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse)
              .text
              ?.arab);
          allJuz.add({
            "juz": juz,
            "start": penampungAyat[0],
            "end": penampungAyat[penampungAyat.length - 1],
            "verses": penampungAyat,
          });
          juz++;
          penampungAyat.clear();
          penampungAyat.add({
            "surah": data.name?.transliteration?.id ?? '',
            "ayat": ayat,
          });
        }
      });
    }
  }
  print("=============");
  print("BERHASIL MEMASUKAN JUZ $juz");
  print("START :");
  print("Ayat : ${(penampungAyat[0]["ayat"] as Verse).number?.inSurah}");
  print((penampungAyat[0]["ayat"] as Verse).text?.arab);
  print("END :");
  print(
      "Ayat:${(penampungAyat[penampungAyat.length - 1]["ayat"] as Verse).number?.inSurah}");
  print((penampungAyat[penampungAyat.length - 1]["ayat"] as Verse).text?.arab);
  allJuz.add({
    "juz": juz,
    "start": penampungAyat[0],
    "end": penampungAyat[penampungAyat.length - 1],
    "verses": penampungAyat,
  });
}
