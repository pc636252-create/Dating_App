
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/controllers/chat_controller.dart';
import 'package:dating_app/routes/app_pages.dart';
import 'package:dating_app/routes/app_routes.dart';
import 'package:dating_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  runApp( DatingApp());
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: .fromSeed(seedColor: Colors.white),
//       ),
//       home:ProfeView(),
//     );
//   }
// }

class DatingApp extends StatelessWidget {
  const DatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
        ),
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}


