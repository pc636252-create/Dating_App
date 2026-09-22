import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authcontrollers/loginController.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  height: screenHeight * 0.5,
                  child: CarouselSlider.builder(
                    itemCount: controller.carouselData.length,
                    options: CarouselOptions(
                      height: screenHeight * 0.5,
                      viewportFraction: 0.70,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      autoPlay: false,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        controller.changePage(index);
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final String svgPath = controller.carouselData[index]['image']!;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          svgPath,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 26),
              Obx(() {
                final int index = controller.currentIndex.value;
                final String title = controller.carouselData[index]['title']!;
                final String description = controller.carouselData[index]['description']!;

                return Container(
                  width: screenWidth * 0.78,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Text(
                          title,
                          key: ValueKey(title),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE94057),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Text(
                          description,
                          key: ValueKey(description),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 8),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.carouselData.length,
                        (index) {
                      final bool selected = index == controller.currentIndex.value;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: selected ? 5 : 5,
                        height: selected ? 5 : 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? const Color(0xFFE94057)
                              : const Color(0xFFD9D9D9),
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signup);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE94057),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  children: [
                    TextSpan(text: 'Already have an account? '),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Color(0xFFE94057),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}