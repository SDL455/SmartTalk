import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:whatsapp/cores/models/chat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = types.User(id: '1');
  final _otherUser = types.User(id: '2');

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    final messages = [
      types.TextMessage(
        author: _otherUser,
        createdAt: DateTime.now().millisecondsSinceEpoch - 60000,
        id: '1',
        text: 'Hello! How are you?',
      ),
      types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch - 30000,
        id: '2',
        text: 'Hi! I\'m doing great, thanks for asking!',
      ),
      types.TextMessage(
        author: _otherUser,
        createdAt: DateTime.now().millisecondsSinceEpoch - 15000,
        id: '3',
        text: 'That\'s wonderful to hear!',
      ),
    ];
    setState(() {
      _messages.addAll(messages);
    });
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final chat = Get.arguments as Chat?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF075E54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                chat?.avatar ?? 'U',
                style: TextStyle(color: Color(0xFF075E54)),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat?.name ?? 'User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      // body: Chat(
      //   messages: _messages,
      //   onSendPressed: _handleSendPressed,
      //   user: _user,
      //   theme: DefaultChatTheme(
      //     primaryColor: Color(0xFF075E54),
      //     secondaryColor: Color(0xFFE8F5E8),
      //     inputBackgroundColor: Colors.white,
      //     inputTextColor: Colors.black,
      //     messageBorderRadius: 15,
      //   ),
      // ),
    );
  }
}
