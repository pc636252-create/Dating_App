import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import '../data/dummy_data.dart';

class MatchesController extends GetxController {
  final RxList<UserModel> matches = <UserModel>[].obs;
  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedInitialData();
  }

  void _seedInitialData() {
    final seedUsers = DummyData.discoverUsers().take(12).toList();
    for (final u in seedUsers) {
      matches.add(u);
    }
    conversations.addAll([
      DummyData.sampleConversation(seedUsers[0]),
      DummyData.sampleConversation(seedUsers[1]),
      DummyData.sampleConversation(seedUsers[2]),
      DummyData.sampleConversation(seedUsers[3]),
    ]);
  }

  void addMatch(UserModel user) {
    if (matches.any((u) => u.id == user.id)) return;
    matches.insert(0, user);
  }

  void ensureConversation(ConversationModel convo) {
    final existingIndex = conversations.indexWhere((c) => c.userId == convo.userId);
    if (existingIndex == -1) {
      conversations.insert(0, convo);
    }
  }

  ConversationModel? conversationForUser(String userId) {
    try {
      return conversations.firstWhere((c) => c.userId == userId);
    } catch (_) {
      return null;
    }
  }
  // int get totalUnread =>
  //     conversations.fold(0, (sum, c) => sum + c.unreadCount);
}
