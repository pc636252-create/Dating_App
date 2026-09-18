import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/dummy_data.dart';
import '../models/user_model.dart';
import '../widgets/match_dialog.dart';
import 'matches_controller.dart';

enum SwipeDirection { none, left, right, up }

class DiscoverController extends GetxController {

  final location = TextEditingController(text: 'Chicago,USA');

  final RxList<UserModel> deck = <UserModel>[].obs;

  final Rx<Offset> dragOffset = Offset.zero.obs;
  final RxDouble angle = 0.0.obs;
  final Rx<SwipeDirection> overlayDirection = SwipeDirection.none.obs;
  final RxBool isDragging = false.obs;

  final RxString interestedIn = 'Girls'.obs;
  final RxDouble maxDistance = 45.0.obs;
  final RxDouble minAge = 20.0.obs;
  final RxDouble maxAge = 30.0.obs;

  static const double swipeThreshold = 110;

  @override
  void onInit() {
    super.onInit();
    resetDeck();
  }

  void resetDeck() {
    deck.assignAll(DummyData.discoverUsers());
  }

  UserModel? get topUser => deck.isNotEmpty ? deck.first : null;
  UserModel? get nextUser => deck.length > 1 ? deck[1] : null;

  void onPanStart(DragStartDetails details) {
    isDragging.value = true;
  }

  void onPanUpdate(DragUpdateDetails details) {
    dragOffset.value += details.delta;
    angle.value = (dragOffset.value.dx / 300).clamp(-0.4, 0.4).toDouble();

    if (dragOffset.value.dx > 40) {
      overlayDirection.value = SwipeDirection.right;
    } else if (dragOffset.value.dx < -40) {
      overlayDirection.value = SwipeDirection.left;
    } else {
      overlayDirection.value = SwipeDirection.none;
    }
  }

  void onPanEnd(DragEndDetails details) {
    isDragging.value = false;
    final dx = dragOffset.value.dx;
    if (dx > swipeThreshold) {
      swipeRight();
    } else if (dx < -swipeThreshold) {
      swipeLeft();
    } else {
      _resetDrag();
    }
  }

  void _resetDrag() {
    dragOffset.value = Offset.zero;
    angle.value = 0.0;
    overlayDirection.value = SwipeDirection.none;
  }

  void swipeLeft() {
    if (topUser == null) return;
    _animateOut(const Offset(-500, 0), () => _popTop());
  }

  void swipeRight() {
    final user = topUser;
    if (user == null) return;
    _animateOut(const Offset(500, 0), () {
      _popTop();
      _maybeMatch(user);
    });
  }

  void superLike() {
    final user = topUser;
    if (user == null) return;
    _animateOut(const Offset(0, -600), () {
      _popTop();
      _maybeMatch(user, forceMatch: true);
    });
  }

  void _animateOut(Offset target, VoidCallback onDone) {
    dragOffset.value = target;
    if (target.dx > 0) {
      angle.value = 0.4;
    } else if (target.dx < 0) {
      angle.value = -0.4;
    } else {
      angle.value = 0.0;
    }    Future.delayed(const Duration(milliseconds: 100), () {
      onDone();
      _resetDrag();
    });
  }

  void _popTop() {
    if (deck.isNotEmpty) {
      deck.removeAt(0);
    }
    if (deck.isEmpty) {
      resetDeck();
    }
  }

  static const String myPhoto = 'https://picsum.photos/seed/me0/600/900';

  void _maybeMatch(UserModel user, {bool forceMatch = false}) {
    final matched = forceMatch || Random().nextBool();
    if (matched) {
      final matchesController = Get.find<MatchesController>();
      matchesController.addMatch(user);
      Get.dialog(
        MatchDialog(user: user, myPhoto: myPhoto),
        barrierDismissible: true,
      );
    }
  }

  void onRejectPressed() => swipeLeft();
  void onLikePressed() => swipeRight();
  void onStarPressed() => superLike();
}
