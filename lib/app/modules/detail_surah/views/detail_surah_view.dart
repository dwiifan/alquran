import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../contants/thema.dart';
import '../../../data/models/detail_surah.dart' as detail;
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments; // menagkap data dari home view page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "SURAH ${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(
          20,
        ),
        children: [
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
                    color: Get.isDarkMode ? kPurpleLight2Color : kWhiteColor,
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
          SizedBox(
            height: 20,
          ),
          FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(surah.number.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // membuat tampilan loding untuk ke halaman home
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                // jika tidak memilik sebuah data maka akan menampilkan text yg di child
                return Center(
                  child: Text("Data Tidak di Temukan."),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.verses?.length ?? 0,
                itemBuilder: (context, index) {
                  if (snapshot.data?.verses?.length == 0) {
                    SizedBox();
                  }
                  detail.Verse? ayat = snapshot.data?.verses?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                              Container(
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
                                child: Center(child: Text("${index + 1}")),
                              ),
                              GetBuilder<DetailSurahController>(
                                builder: (c) => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: "BOOKMARK",
                                            middleText: "Pilih jenis bookmark",
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  c.addBookmark(
                                                      true,
                                                      snapshot.data!,
                                                      ayat!,
                                                      index);
                                                },
                                                child: Text(
                                                  "LAST_READ",
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPurpleColor,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  c.addBookmark(
                                                      false,
                                                      snapshot.data!,
                                                      ayat!,
                                                      index);
                                                },
                                                child: Text(
                                                  "BOOKMARK",
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPurpleColor,
                                                ),
                                              ),
                                            ]);
                                      },
                                      icon: Icon(
                                        Icons.bookmark_add_outlined,
                                      ),
                                    ),
                                    //kondisi => stop => button play
                                    //kondisi => playing => button pause & button stop
                                    //kondisi => pause => button resume & button stop
                                    (ayat?.kondisiAudio == "stop")
                                        ? IconButton(
                                            onPressed: () {
                                              c.playAudio(ayat);
                                            },
                                            icon: Icon(
                                              Icons.play_arrow,
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              (ayat?.kondisiAudio == "playing")
                                                  ? IconButton(
                                                      onPressed: () {
                                                        c.pauseAudio(ayat!);
                                                      },
                                                      icon: Icon(
                                                        Icons.pause,
                                                      ),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        c.resumeAudio(ayat!);
                                                      },
                                                      icon: Icon(
                                                        Icons.play_arrow,
                                                      ),
                                                    ),
                                              IconButton(
                                                onPressed: () {
                                                  c.stopAudio(ayat!);
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
                          "${ayat!.text?.arab}",
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
                        "${ayat.text?.transliteration?.en}",
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
                        "${ayat.translation?.id}",
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
              );
            },
          ),
        ],
      ),
    );
  }
}
