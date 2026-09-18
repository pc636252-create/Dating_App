import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onLike;
  final VoidCallback onStar;

  const ActionButtonsRow({
    super.key,
    required this.onReject,
    required this.onLike,
    required this.onStar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _circleButton(icon: Icons.close, color: Colors.orange, size: 54, iconSize: 35, onTap: onReject),
        const SizedBox(width: 20),
        _circleButton(icon: Icons.favorite, color:Colors.white,backgroundColor: AppColors.primary, size: 75, iconSize: 30, onTap: onLike),
        const SizedBox(width: 20),
        _circleButton(icon: Icons.star, color:AppColors.star, size: 54, iconSize: 26, onTap: onStar),
      ],
    );
  }


  Widget _circleButton({
    required IconData icon,
    required Color color,
    required double size,
    required double iconSize,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
