import 'dart:developer';

import 'package:alhadid/models/hadith.dart';
import 'package:alhadid/presentations/hadith_details_screen/get_controller/hadith_details_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        appBar: const CustomAppBar(),
        body: Obx(
          () {
            if (hadithDetailsController.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (hadithDetailsController.error.value) {
              return const Center(
                child: Text("Couldn't load data"),
              );
            }
            if (hadithDetailsController.success.value) {
              return ListView.builder(
                itemCount: hadithDetailsController.hadithList.length,
                itemBuilder: (context, index) {
                  Hadith hadith = hadithDetailsController.hadithList[index];
                  log(hadith.toJson());
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                      text:
                                          "${hadith.chapterId}/${hadith.sectionId}."
                                          "অধ্যায়ঃ ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(17, 140, 111, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: hadith.bn,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      )
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

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
                Navigator.pop(context);
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
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'ওহীর সূচনা অধ্যায়',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
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
