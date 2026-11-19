class Conversation {
  final String id;
  final String clientId;
  final String professionalId;
  final String clientName;
  final String professionalName;
  final String lastMessage;
  final DateTime updatedAt;
  final int unreadMessages;

  Conversation({
    required this.id,
    required this.clientId,
    required this.professionalId,
    required this.clientName,
    required this.professionalName,
    required this.lastMessage,
    required this.updatedAt,
    this.unreadMessages = 0,
  });
}
