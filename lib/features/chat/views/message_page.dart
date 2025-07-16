import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/cores/models/chat.dart';
import 'package:whatsapp/features/chat/views/build_app_bar.dart';
import 'widgets/chat_message_list.dart';
import 'widgets/chat_input_field.dart';
import 'dart:io';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  final List<types.Message> _messages = [];
  final _user = types.User(id: '1');
  final _otherUser = types.User(id: '2');
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadMessages();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    final messages = [
      types.TextMessage(
        author: _otherUser,
        createdAt: DateTime.now().millisecondsSinceEpoch - 60000,
        id: '1',
        text: 'ສະບາຍດີ! ເປັນແນວໃດແລ້ວ? 😊',
      ),
      types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch - 30000,
        id: '2',
        text: 'ສະບາຍດີ! ຂ້ອຍສະບາຍດີ, ຂອບໃຈທີ່ຖາມ! 🌟',
      ),
      types.TextMessage(
        author: _otherUser,
        createdAt: DateTime.now().millisecondsSinceEpoch - 15000,
        id: '3',
        text: 'ດີໃຈທີ່ໄດ້ຍິນແບບນັ້ນ! ວັນນີ້ມີຫຍັງພິເສດບໍ? 🎉',
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

  void _handleSendImage(File imageFile) {
    final imageMessage = types.ImageMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: imageFile.path.split('/').last,
      size: imageFile.lengthSync(),
      uri: imageFile.path,
    );
    _addMessage(imageMessage);
  }

  @override
  Widget build(BuildContext context) {
    final chat = Get.arguments as Chat?;

    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: buildAppBar(chat),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.backgroundGrey,
                        AppTheme.backgroundGrey.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ChatMessageList(messages: _messages, user: _user),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ChatInputField(
                  onSendPressed: _handleSendPressed,
                  onSendImage: _handleSendImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
