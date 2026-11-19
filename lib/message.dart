class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime sentAt;
  final bool isRead;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.sentAt,
    this.isRead = false,
  });
}
