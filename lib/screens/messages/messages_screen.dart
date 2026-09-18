import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../controllers/matches_controller.dart';
import '../../main.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../chat/chat_screen.dart';
import '../filters/filters_screen.dart';
import '../story_view/story.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Row(
            children: [
              Text('Messages', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500, color: AppColors.textDark)),
            SizedBox(width: Get.width*0.4),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  const FiltersScreen(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 0.8,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
                ),
                child: const Icon(Icons.tune, color: Colors.red),
              ),
            ),
          ]),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: Get.height * 0.06,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 0.8,
              ),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey.shade400,fontSize: 15),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 30,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text("Activities",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: Get.height * (111 / 812),
          child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.matches.length,
                itemBuilder: (context, index) {
                  final user = controller.matches[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => StoryViewScreen(users: controller.matches, initialIndex: index)),
                    // onTap: () => Get.toNamed(AppRoutes.userdetaile, arguments: user),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: CachedNetworkImageProvider(user.mainPhoto),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 60,
                            child: Text(
                              user.name.split(' ').first,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text("Messages",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: 12),
        Expanded(
          child: Obx(() {
            if (controller.conversations.isEmpty) {
              return const Center(child: Text('No messages yet.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.conversations.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 84),
              itemBuilder: (context, index) {
                final convo = controller.conversations[index];
                final lastMsg = convo.lastMessage;
                final unread = convo.unreadCount > 0;
                return ListTile(
                  onTap: () {
                    Get.bottomSheet(
                      ChatScreen(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      settings: RouteSettings(
                        arguments: convo,
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  leading: Stack(
                    children: [
                      CircleAvatar(radius: 28, backgroundImage: CachedNetworkImageProvider(convo.avatar)),
                    ],
                  ),
                  title: Text(convo.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    lastMsg?.text ?? 'Say hello 👋',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: unread ? AppColors.textDark : AppColors.textGrey,
                      fontWeight: unread ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (lastMsg != null)
                        Text(
                          DateFormat('hh:mm ').format(lastMsg.time),
                          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                        )
                      // if (unread)
                      //   Container(
                      //     margin: const EdgeInsets.only(top: 6),
                      //     width: 10,
                      //     height: 10,
                      //     decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      //   ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
