import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/cores/models/user.dart';

class ProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isEditing = false.obs;
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var profileImage = Rx<File?>(null);
  UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (!doc.exists) throw Exception('User not found');
      final data = doc.data()!;
      userModel = UserModel.fromMap(data, uid);
      final nameParts = userModel!.displayName.split(' ');
      firstNameController.text = nameParts.isNotEmpty ? nameParts.first : '';
      lastNameController.text = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';
      phoneController.text = userModel?.phone ?? '';
      emailController.text = userModel?.email ?? '';
      passwordController.text = '';
      // profileImage: not loaded from network in this example
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');
      final displayName =
          firstNameController.text.trim() +
          (lastNameController.text.trim().isNotEmpty
              ? ' ' + lastNameController.text.trim()
              : '');
      final updatedUser = UserModel(
        uid: uid,
        displayName: displayName,
        photoUrl: userModel
            ?.photoUrl, // You can update this if you implement image saving
        status: userModel?.status,
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );
      // Update Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'displayName': updatedUser.displayName,
        'email': updatedUser.email,
        'photoUrl': updatedUser.photoUrl,
        'status': updatedUser.status,
        'phone': updatedUser.phone,
      });
      // Update Firebase Auth profile
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(updatedUser.displayName);
        if (updatedUser.photoUrl != null) {
          await currentUser.updatePhotoURL(updatedUser.photoUrl);
        }
        if (updatedUser.email != null &&
            updatedUser.email != currentUser.email) {
          await currentUser.updateEmail(updatedUser.email!);
        }
      }
      userModel = updatedUser;
      isEditing.value = false;
      Get.snackbar('Success', 'ບັນທຶກຂໍ້ມູນສຳເລັດແລ້ວ');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
