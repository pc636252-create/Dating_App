import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_controller.dart';
import '../controllers/matches_controller.dart';
import '../utils/app_colors.dart';
import 'discover/discover_screen.dart';
import 'matches/matches_screen.dart';
import 'messages/messages_screen.dart';
import 'profile/own_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.put(NavController());
    final matchesController = Get.put(MatchesController());

    final screens = const [
      DiscoverScreen(),
      MatchesScreen(),
      MessagesScreen(),
      OwnProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: nav.tabIndex.value,
              children: screens,
            )),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(nav, 0, Icons.local_fire_department_rounded),
                  _navItem(nav, 1, Icons.favorite_rounded),
                  _navItem(nav, 2, Icons.chat_bubble_rounded,
                      // badgeCount: matchesController.totalUnread
                  ),
                  _navItem(nav, 3, Icons.person_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(NavController nav, int index, IconData icon, {int badgeCount = 0}) {
    final selected = nav.tabIndex.value == index;
    return GestureDetector(
      onTap: () => nav.changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              size: 26,
              color: selected ? AppColors.primary : AppColors.reject,
            ),
            if (badgeCount > 0)
              Positioned(
                right: -6,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '$badgeCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
