import 'package:dating_app/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui'; // Required for ImageFilter.blur
import '../../controllers/discover_controller.dart';
import '../../controllers/matches_controller.dart';
import '../../data/dummy_data.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../chat/chat_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();
    final c = Get.find<DiscoverController>();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Matches',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.swap_vert,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'This is a list of people who have liked you and your matches.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[200], thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[200], thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (controller.matches.isEmpty) {
                      return const Center(
                        child: Text('No matches yet !'),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.matches.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final user = controller.matches[index];
                        return GestureDetector(
                          onTap: () {
                            final convo = controller.conversationForUser(user.id) ??
                                DummyData.sampleConversation(user);
                            controller.ensureConversation(convo);
                            // Get.bottomSheet(
                            //   ChatScreen(),
                            //   isScrollControlled: true,
                            //   backgroundColor: Colors.transparent,
                            //   // arguments: convo
                            // );
                            Get.toNamed(AppRoutes.chat, arguments: convo);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: user.mainPhoto,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.1),
                                        Colors.black.withOpacity(0.7),
                                      ],
                                      stops: const [0.6, 0.8, 1.0],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${user.name.split(' ').first}, ${user.age}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ClipRRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          height: Get.height*0.05,
                                          color: Colors.white.withOpacity(0.15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {Get.back();},
                                                  behavior: HitTestBehavior.opaque,
                                                  child: const Center(
                                                    child: Icon(Icons.close_outlined, color: Colors.white, size: 22),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 24,
                                                color: Colors.white.withOpacity(0.3),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: (){
                                                    c.onLikePressed();
                                                  },
                                                  behavior: HitTestBehavior.opaque,
                                                  child: const Center(
                                                    child: Icon(Icons.favorite, color: Colors.white, size: 22),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                 );
               },
             );
           }),
          ),
       ],
      )
     )
   );
  }
}
