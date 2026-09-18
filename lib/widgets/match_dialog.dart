import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../data/dummy_data.dart';
import '../controllers/matches_controller.dart';

class MatchDialog extends StatelessWidget {
  final UserModel user;
  final String myPhoto;

  const MatchDialog({super.key, required this.user, required this.myPhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height*0.3,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.25,
                      top: 20,
                      child: _matchCard(
                        user.mainPhoto,
                        rotation: 0.17,
                        heartAlignment: Alignment.topLeft,
                        heartOffset: const Offset(-15, -15),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.3,
                      bottom: 20,
                      child: _matchCard(
                        myPhoto,
                        rotation: -0.12 ,
                        heartAlignment: Alignment.bottomLeft,
                        heartOffset: const Offset(-15, 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Text(
                "It's a match, ${user.name.split(' ').first}!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE94057),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start a conversation now with each other',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: Get.width*0.8,
                height: Get.height*0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE94057),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    final convo = DummyData.sampleConversation(user);
                    Get.find<MatchesController>().ensureConversation(convo);
                    Get.toNamed(AppRoutes.chat, arguments: convo);
                  },
                  child: const Text(
                    'Say hello',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: Get.width*0.8,
                height: Get.height*0.06,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:  Color(0xFFFDECEE),
                    foregroundColor: Color(0xFFE94057),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Keep swiping',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _matchCard(
      String url, {
        required double rotation,
        required Alignment heartAlignment,
        required Offset heartOffset,
      }) {
    return Transform.rotate(
      angle: rotation,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: Get.width*0.3,
            height: Get.height*0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(color: Colors.grey.shade300),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: heartAlignment,
              child: Transform.translate(
                offset: heartOffset,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.favorite_rounded, color: Color(0xFFE94057), size: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
