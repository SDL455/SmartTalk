import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> registerWithEmail(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);

      // เพิ่มส่วนนี้เพื่อบันทึกข้อมูลลง Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'displayName': name,
            'phone': phone,
            'email': email,
            'photoUrl': userCredential.user?.photoURL ?? '',
            'status': 'online', // หรือค่า default อื่นๆ
          });

      Get.snackbar('Success', 'Account created successfully!');
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Registration failed';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Login failed';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
