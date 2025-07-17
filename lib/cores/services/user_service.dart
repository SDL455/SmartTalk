import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/cores/models/user.dart';

class UserService {
  static const _keyUid = 'user_uid';
  static const _keyDisplayName = 'user_display_name';
  static const _keyPhotoUrl = 'user_photo_url';
  static const _keyStatus = 'user_status';
  static const _keyEmail = 'user_email';
  static const _keyPhone = 'user_phone';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUid, user.uid);
    await prefs.setString(_keyDisplayName, user.displayName);
    if (user.photoUrl != null) {
      await prefs.setString(_keyPhotoUrl, user.photoUrl!);
    } else {
      await prefs.remove(_keyPhotoUrl);
    }
    if (user.status != null) {
      await prefs.setString(_keyStatus, user.status!);
    } else {
      await prefs.remove(_keyStatus);
    }
    if (user.email != null) {
      await prefs.setString(_keyEmail, user.email!);
    } else {
      await prefs.remove(_keyEmail);
    }
    if (user.phone != null) {
      await prefs.setString(_keyPhone, user.phone!);
    } else {
      await prefs.remove(_keyPhone);
    }
  }

  Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(_keyUid);
    final displayName = prefs.getString(_keyDisplayName);
    if (uid == null || displayName == null) return null;
    return UserModel(
      uid: uid,
      displayName: displayName,
      photoUrl: prefs.getString(_keyPhotoUrl),
      status: prefs.getString(_keyStatus),
      email: prefs.getString(_keyEmail),
      phone: prefs.getString(_keyPhone),
    );
  }
}
