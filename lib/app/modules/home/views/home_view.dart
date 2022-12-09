import 'package:alquran/app/contants/thema.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Al-Qur'an"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      kPurpleColor,
                      kPurpleDrakColor,
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -50,
                            right: 0,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: 180,
                                height: 180,
                                child: Image.asset(
                                  "assets/images/alquran-icon.png",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: kWhiteColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir dibaca",
                                      style: TextStyle(
                                        color: kWhiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Al-Fatihah",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kWhiteColor,
                                      ),
                                    ),
                                    Text(
                                      "Juz 1 | Ayat 5",
                                      style: TextStyle(
                                        color: kWhiteColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Juz",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder<List<Surah>>(
                    future: controller.getAllSurah(),
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
                        itemCount: snapshot.data!
                            .length, // menampilkan seluruh data yg ada di API
                        itemBuilder: (context, index) {
                          Surah surah = snapshot.data![index]; // data surah
                          return ListTile(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_SURAH,
                                arguments: surah,
                              ); // mengirim data ke detail_surah page
                            },
                            leading: Obx(
                              () => Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller.isDark.isTrue
                                          ? "assets/images/octagonal-icon-dark.png"
                                          : "assets/images/octagonal-icon-light.png",
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${surah.number}",
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "${surah.name?.transliteration?.id ?? 'Error...'}",
                            ), // disini memanggil data surah nama
                            subtitle: Text(
                              "${surah.numberOfVerses}7 Ayat | ${surah.revelation?.id ?? 'Error...'}",
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ), // disini memanggil data ayat dan diturunkan dimana ${surah.revelation?.id ?? 'Error...'}
                            trailing: Text(
                              "${surah.name?.short ?? 'Error...'}",
                            ), // disini memanggil data tulisan arab
                          );
                        },
                      );
                    },
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: controller.getAllJuz(),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> dataMapPerJuz =
                              snapshot.data![index];
                          return ListTile(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_JUZ,
                                  arguments:
                                      dataMapPerJuz); // mengirim data ke detail_surah page
                            },
                            leading: Obx(
                              () => Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller.isDark.isTrue
                                          ? "assets/images/octagonal-icon-dark.png"
                                          : "assets/images/octagonal-icon-light.png",
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "Juz ${index + 1}",
                            ), // disini memanggil data surah nama
                            isThreeLine: true,
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Mulai dari ${(dataMapPerJuz['start']['surah'] as detail.DetailSurah).name?.transliteration?.id} ayat ${(dataMapPerJuz['start']['ayat'] as detail.Verse).number?.inSurah}",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Text(
                                  "Sampai ${(dataMapPerJuz['end']['surah'] as detail.DetailSurah).name?.transliteration?.id} ayat ${(dataMapPerJuz['end']['ayat'] as detail.Verse).number?.inSurah}",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Center(
                    child: Text("page 3"),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? kPurpleColor : kWhiteColor,
          ),
        ),
      ),
    );
  }
}
