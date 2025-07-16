import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/cores/models/chat.dart';
import 'package:whatsapp/features/chat/views/message_page.dart';

class ChatPage extends StatelessWidget {
  final List<Chat> chats = [
    Chat(
      name: 'Alice Johnson',
      lastMessage: 'Hey! How are you doing?',
      time: '10:30 AM',
      unreadCount: 2,
      avatar: 'A',
    ),
    Chat(
      name: 'Bob Smith',
      lastMessage: 'Can we meet tomorrow?',
      time: '9:15 AM',
      unreadCount: 0,
      avatar: 'B',
    ),
    Chat(
      name: 'Carol Davis',
      lastMessage: 'Thanks for the help!',
      time: 'Yesterday',
      unreadCount: 1,
      avatar: 'C',
    ),
    Chat(
      name: 'David Wilson',
      lastMessage: 'See you later!',
      time: 'Yesterday',
      unreadCount: 0,
      avatar: 'D',
    ),
  ];
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.primaryColor,
            child: Text(chat.avatar, style: TextStyle(color: Colors.white)),
          ),
          title: Text(chat.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(chat.lastMessage),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(chat.time, style: TextStyle(fontSize: 12)),
              if (chat.unreadCount > 0)
                Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat.unreadCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          onTap: () {
            Get.to(() => MessagePage(), arguments: chat);
          },
        );
      },
    );
  }
}
