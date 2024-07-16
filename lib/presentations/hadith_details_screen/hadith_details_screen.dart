import 'dart:io';

import 'package:alhadid/models/hadith.dart';
import 'package:alhadid/models/section.dart';
import 'package:alhadid/presentations/hadith_details_screen/get_controller/hadith_details_controller.dart';
import 'package:bangla_converter/convert_file/convert_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HadithDetailsScreen extends StatefulWidget {
  const HadithDetailsScreen({super.key});

  @override
  State<HadithDetailsScreen> createState() => _HadithDetailsScreenState();
}

class _HadithDetailsScreenState extends State<HadithDetailsScreen> {
  final hadithDetailsController = Get.put(HadithDetailsController());

  @override
  void initState() {
    hadithDetailsController.initializeDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(
      () {
        if (hadithDetailsController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Color.fromRGBO(17, 140, 111, 1),
            ),
          );
        }
        if (hadithDetailsController.error.value) {
          return const Center(
            child: Text("Couldn't load data"),
          );
        }
        if (hadithDetailsController.success.value) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
            appBar: CustomAppBar(
              title: hadithDetailsController.bookList.first.bookName!,
              subtitle: hadithDetailsController.chapterList.first.title!,
            ),
            body: ListView.builder(
              itemCount: hadithDetailsController.sectionList.length,
              itemBuilder: (context, index) {
                Section section = hadithDetailsController.sectionList[index];
                List<Hadith> hadithList =
                    hadithDetailsController.hadithList.where(
                  (p0) {
                    return p0.sectionId == section.id;
                  },
                ).toList();
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: "${section.number} ",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'kalpurush',
                                      color: Color.fromRGBO(17, 140, 111, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: index == 0 ? section.title : "",
                                        style: const TextStyle(
                                          fontFamily: 'kalpurush',
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible: section.preface != null &&
                                section.preface!.isNotEmpty,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey.shade200,
                                  thickness: 1,
                                  height: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  section.preface ?? "",
                                  style: TextStyle(
                                    fontFamily: 'kalpurush',
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      hadithList.length,
                      (index) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/customShape.png",
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        hadithDetailsController
                                                .bookList.first.abvrCode ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hadithDetailsController
                                                .bookList.first.title ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'kalpurush',
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "হাদিস: ${BanglaConverter.engToBan(hadithList[index].hadithId)}",
                                        style: const TextStyle(
                                          fontFamily: 'kalpurush',
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(17, 140, 111, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // color: const Color.fromRGBO(
                                          //     74, 182, 146, 1),
                                          color: Color(
                                            int.parse(
                                              "0xFF${hadithList[index].gradeColor!.substring(1)}",
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            hadithList[index].grade ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_vert_rounded,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                hadithList[index].ar ?? "",
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${hadithList[index].narrator} থেকে বর্ণিত:",
                                style: const TextStyle(
                                  fontFamily: 'kalpurush',
                                  fontSize: 13,
                                  color: Color.fromRGBO(17, 140, 111, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${hadithList[index].bn}",
                                style: const TextStyle(
                                  fontFamily: 'kalpurush',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomShapePainter(),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              icon: const Icon(
                color: Colors.white,
                size: 20,
                Icons.arrow_back_ios,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'সহিহ বুখারী',
                  style: TextStyle(
                    fontFamily: 'kalpurush',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'ওহীর সূচনা অধ্যায়',
                  style: TextStyle(
                    fontFamily: 'kalpurush',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 22,
              width: 20,
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Image.asset(
                "assets/images/filter.png",
                color: Colors.white,
                height: 22,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(95.0);
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(17, 140, 111, 1)
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height * 0.80, 20, size.height * 0.80);
    path.lineTo(20, size.height * 0.80);
    path.lineTo(size.width * 0.95, size.height * 0.80);
    path.quadraticBezierTo(
        size.width, size.height * 0.80, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
