import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/cores/models/user.dart';

class ContactController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();
      users.value = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  List<UserModel> get onlineUsers =>
      users.where((u) => u.status == 'online').toList();
}
