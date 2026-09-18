import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/discover_controller.dart';
import '../../utils/app_colors.dart';

class OwnProfileScreen extends StatelessWidget {
  const OwnProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('My Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: AppColors.textDark)),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: CachedNetworkImageProvider(DiscoverController.myPhoto),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text('You, 24', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const Center(
            child: Text('Delhi, India', style: TextStyle(color: AppColors.textGrey)),
          ),
          const SizedBox(height: 30),
          _statsRow(),
          const SizedBox(height: 30),
          _settingsTile(Icons.edit, 'Edit profile'),
          _settingsTile(Icons.tune, 'Discovery preferences'),
          _settingsTile(Icons.notifications_none, 'Notifications'),
          _settingsTile(Icons.lock_outline, 'Privacy & safety'),
          _settingsTile(Icons.logout, 'Log out', color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _StatItem(label: 'Matches', value: '24'),
        _StatItem(label: 'Likes', value: '182'),
        _StatItem(label: 'Super Likes', value: '5'),
      ],
    );
  }

  Widget _settingsTile(IconData icon, String label, {Color color = AppColors.textDark}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textGrey),
      onTap: () {},
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
      ],
    );
  }
}
