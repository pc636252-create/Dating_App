import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  late ConversationModel conversation;
  final TextEditingController textController = TextEditingController();
  final RxBool isTyping = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    conversation = Get.arguments as ConversationModel;
    for (final m in conversation.messages) {
      if (!m.isMe) m.isRead = true;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    conversation.messages.add(
      MessageModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: text,
        isMe: true,
        time: DateTime.now(),
        isRead: true,
      ),
    );
    textController.clear();
    update();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
