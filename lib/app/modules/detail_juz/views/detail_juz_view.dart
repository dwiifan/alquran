import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../contants/thema.dart';
import '../controllers/detail_juz_controller.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Juz ${dataMapPerJuz["juz"]}"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            itemCount: (dataMapPerJuz["verses"] as List).length,
            itemBuilder: (context, index) {
              if ((dataMapPerJuz["verses"] as List).length == 0) {
                return Center(
                  child: Text("Data tidak ditemukan"),
                );
              }

              Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];

              detail.DetailSurah surah = ayat['surah'];
              detail.Verse verse = ayat["ayat"];

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (verse.number?.inSurah == 1)
                    GestureDetector(
                      onTap: () => Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? kPurpleLight2Color
                                  : kWhiteColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Tafsir ${surah.name?.transliteration?.id ?? 'Tidak ada tafsir pada surah'}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${surah.tafsir?.id ?? 'Tafsir tidak ada pada surah'}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              kPurpleColor,
                              kPurpleDrakColor,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            20,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                ),
                              ),
                              Text(
                                "( ${surah.name?.translation?.id?.toUpperCase() ?? 'Error...'} )",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${surah.numberOfVerses ?? 'Error ... '} Ayat | ${surah.revelation?.id ?? 'Error ...'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPurpleLight2Color.withOpacity(0.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 15,
                                ),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Get.isDarkMode
                                        ? "assets/images/octagonal-icon-dark.png"
                                        : "assets/images/octagonal-icon-light.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                    child: Text("${verse.number?.inSurah}")),
                              ),
                              Text(
                                "${surah.name?.transliteration?.id ?? ''}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<DetailJuzController>(
                            builder: (c) => Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                  ),
                                ),
                                //kondisi => stop => button play
                                //kondisi => playing => button pause & button stop
                                //kondisi => pause => button resume & button stop
                                (verse.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(verse);
                                        },
                                        icon: Icon(
                                          Icons.play_arrow,
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (verse.kondisiAudio == "playing")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(verse);
                                                  },
                                                  icon: Icon(
                                                    Icons.pause,
                                                  ),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(verse);
                                                  },
                                                  icon: Icon(
                                                    Icons.play_arrow,
                                                  ),
                                                ),
                                          IconButton(
                                            onPressed: () {
                                              c.stopAudio(verse);
                                            },
                                            icon: Icon(
                                              Icons.stop,
                                            ),
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22,
                    ),
                    child: Text(
                      "${(ayat['ayat'] as detail.Verse).text?.arab}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${(ayat['ayat'] as detail.Verse).text?.transliteration?.en}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${(ayat['ayat'] as detail.Verse).translation?.id}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
