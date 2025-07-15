import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatInputField extends StatefulWidget {
  final void Function(types.PartialText) onSendPressed;
  final void Function(File)? onSendImage;
  const ChatInputField({
    Key? key,
    required this.onSendPressed,
    this.onSendImage,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false;
  final ImagePicker _picker = ImagePicker();

  void _send() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendPressed(types.PartialText(text: text));
      _controller.clear();
    }
  }

  void _toggleEmojiPicker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _onCameraPressed() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xFF075E54)),
                title: Text('Take Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                    maxWidth: 1024,
                  );
                  if (pickedFile != null && widget.onSendImage != null) {
                    widget.onSendImage!(File(pickedFile.path));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Color(0xFF075E54)),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                    maxWidth: 1024,
                  );
                  if (pickedFile != null && widget.onSendImage != null) {
                    widget.onSendImage!(File(pickedFile.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onEmojiSelected(Emoji emoji) {
    final text = _controller.text;
    final selection = _controller.selection;
    final newText = text.replaceRange(
      selection.start,
      selection.end,
      emoji.emoji,
    );
    final emojiLength = emoji.emoji.length;
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(
      offset: selection.start + emojiLength,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Color(0xFF075E54),
                  ),
                  onPressed: _toggleEmojiPicker,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF075E54)),
                  onPressed: _onCameraPressed,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF075E54)),
                  onPressed: _send,
                ),
              ],
            ),
          ),
          if (_showEmojiPicker)
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _onEmojiSelected(emoji);
                },
                textEditingController: _controller,
                config: Config(
                  height: 250,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 32,
                    backgroundColor: Color(0xFFF2F2F2),
                  ),
                  categoryViewConfig: CategoryViewConfig(
                    indicatorColor: Color(0xFF075E54),
                    iconColor: Colors.grey,
                    iconColorSelected: Color(0xFF075E54),
                    backspaceColor: Color(0xFF075E54),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
