import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String sender;
  final String text;

  ChatMessage({
    required this.sender,
    required this.text,
  });
}

class ChatState {
  final List<ChatMessage> messages;

  ChatState({List<ChatMessage>? messages}) : messages = messages ?? [];

  ChatState copyWith({List<ChatMessage>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState());

  void addMessage({required String sender, required String text}) {
    state = ChatState(
      messages: [...state.messages, ChatMessage(sender: sender, text: text)],
    );
  }

  void clearMessages() {
    state = ChatState(messages: []);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});