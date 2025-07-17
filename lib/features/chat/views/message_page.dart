import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:whatsapp/cores/colors/%E0%BA%B1app_theme.dart';
import 'package:whatsapp/features/chat/views/build_app_bar.dart';
import 'widgets/chat_message_list.dart';
import 'widgets/chat_input_field.dart';
import 'dart:io';
import 'package:whatsapp/cores/models/user.dart';
import 'package:whatsapp/features/chat/controllers/chat_controller.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late types.User _user;
  late types.User _otherUser;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ChatController _chatController;

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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getChatId(String uid1, String uid2) {
    // Always generate the same chatId for a pair
    final sorted = [uid1, uid2]..sort();
    return sorted.join('_');
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );
    _chatController.sendMessage(textMessage);
  }

  void _handleSendImage(File imageFile) async {
    await _chatController.sendImageMessage(imageFile, _user);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel otherUser = Get.arguments as UserModel;
    _otherUser = types.User(
      id: otherUser.uid,
      firstName: otherUser.displayName,
    );
    // TODO: Replace with actual current user from AuthController
    _user = types.User(id: 'currentUserId', firstName: 'Me');
    final chatId = _getChatId(_user.id, _otherUser.id);
    if (Get.isRegistered<ChatController>()) {
      _chatController = Get.find<ChatController>();
    } else {
      _chatController = Get.put(ChatController(chatId));
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: buildAppBar(null),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ChatMessageList(
                    messages: _chatController.messages.toList(),
                    user: _user,
                  ),
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
