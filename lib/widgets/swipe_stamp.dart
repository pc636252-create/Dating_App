import 'package:flutter/material.dart';
import '../controllers/discover_controller.dart';

class SwipeStamp extends StatelessWidget {
  final SwipeDirection direction;
  const SwipeStamp({super.key, required this.direction});

  @override
  Widget build(BuildContext context) {
    if (direction == SwipeDirection.none) return const SizedBox.shrink();

    final isLike = direction == SwipeDirection.right;

    final iconData = isLike ? Icons.favorite_rounded : Icons.close_rounded;
    final iconColor = isLike ?  Color(0xFFE94057) : Colors.orange;

    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor,
            size: 42,
          ),
        ),
      ),
    );
  }
}
