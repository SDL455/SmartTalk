import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp/cores/models/chat.dart';
import 'package:whatsapp/features/chat/views/chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartTalk', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF075E54),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.camera_alt, color: Colors.white)),
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Camera Tab
          Center(child: Text('Camera')),
          // Chats Tab
          ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF075E54),
                  child: Text(
                    chat.avatar,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  chat.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                  Get.to(() => ChatPage(), arguments: chat);
                },
              );
            },
          ),
          // Status Tab
          Center(child: Text('Status')),
          // Calls Tab
          Center(child: Text('Calls')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF25D366),
        child: Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}
