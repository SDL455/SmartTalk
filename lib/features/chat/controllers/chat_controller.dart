import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ChatController extends GetxController {
  final String chatId;
  RxList<types.Message> messages = <types.Message>[].obs;

  ChatController(this.chatId);

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          messages.value = snapshot.docs.map((doc) {
            final data = doc.data();
            if (data['type'] == 'image') {
              return types.ImageMessage(
                id: doc.id,
                author: types.User(id: data['authorId']),
                createdAt: data['createdAt'],
                uri: data['imageUrl'],
                name: data['name'] ?? '',
                size: 0,
              );
            } else {
              return types.TextMessage(
                id: doc.id,
                author: types.User(id: data['authorId']),
                createdAt: data['createdAt'],
                text: data['text'],
              );
            }
          }).toList();
        });
  }

  Future<void> sendMessage(types.TextMessage message) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
          'authorId': message.author.id,
          'createdAt': message.createdAt,
          'text': message.text,
        });
  }

  Future<void> sendImageMessage(File imageFile, types.User author) async {
    final fileName =
        DateTime.now().millisecondsSinceEpoch.toString() +
        '_' +
        imageFile.path.split('/').last;
    final ref = FirebaseStorage.instance
        .ref()
        .child('chat_images')
        .child(chatId)
        .child(fileName);
    // final uploadTask = await ref.putFile(imageFile);
    final imageUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
          'authorId': author.id,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'type': 'image',
          'imageUrl': imageUrl,
          'name': fileName,
        });
  }
}
