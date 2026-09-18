import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryViewScreen extends StatefulWidget {
  final List<dynamic> users;
  final int initialIndex;
  const StoryViewScreen({super.key, required this.users, required this.initialIndex});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> with SingleTickerProviderStateMixin {
  late int currentIndex;
  late AnimationController _controller;
  final Duration storyDuration = const Duration(seconds: 5);
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = AnimationController(vsync: this, duration: storyDuration);
    _startStory();
  }

  void _startStory() {
    _controller.reset();
    _controller.forward();
    _controller.addStatusListener(_onStoryComplete);
  }

  void _onStoryComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _nextStory() {
    _controller.removeStatusListener(_onStoryComplete);
    if (currentIndex < widget.users.length - 1) {
      setState(() => currentIndex++);
      _startStory();
    } else {
      Navigator.pop(context);
    }
  }

  void _prevStory() {
    _controller.removeStatusListener(_onStoryComplete);
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _startStory();
    } else {
      _startStory();
    }
  }

  void _pause() => _controller.stop();
  void _resume() => _controller.forward();

  @override
  void dispose() {
    _controller.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.users[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _pause(),
        onTapUp: (details) {
          _resume();
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _prevStory();
          } else {
            _nextStory();
          }
        },
        onLongPressStart: (_) => _pause(),
        onLongPressEnd: (_) => _resume(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: user.mainPhoto,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: Colors.grey[900]),
              errorWidget: (_, __, ___) => Container(color: Colors.grey[900]),
            ),
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 45, left: 8, right: 8,
              child: Row(
                children: List.generate(widget.users.length, (i) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          double value = 0;
                          if (i < currentIndex) value = 1;
                          if (i == currentIndex) value = _controller.value;
                          return FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              top: 60, left: 12, right: 12,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: CachedNetworkImageProvider(user.mainPhoto),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20, left: 12, right: 12,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white,
                              width: 1
                          ),
                        ),
                        child: TextField(
                          controller: messageController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Your message...',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // IconButton(
                    //   icon: const Icon(Icons.favorite_border, color: Colors.white),
                    //   onPressed: () {},
                    // ),
                    GestureDetector(
                      onTap: messageController.clear,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white,
                            width: 1
                          ),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 8)],
                        ),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.send, color: Colors.white60),
                    //   onPressed: () {
                    //     messageController.clear();
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}