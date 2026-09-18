class MessageModel {
  final String id;
  final String text;
  final bool isMe;
  final DateTime time;
  bool isRead;

  MessageModel({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.isRead = false,
  });
}

class ConversationModel {
  final String id;
  final String userId;
  final String name;
  final String avatar;
  final List<MessageModel> messages;
  final bool isOnline;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatar,
    required this.messages,
    this.isOnline = false,
  });

  MessageModel? get lastMessage => messages.isEmpty ? null : messages.last;

  int get unreadCount =>
      messages.where((m) => !m.isMe && !m.isRead).length;
}
