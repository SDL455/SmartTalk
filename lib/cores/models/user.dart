class UserModel {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final String? status;
  final String? email;
  final String? phone;

  UserModel({
    required this.uid,
    required this.displayName,
    this.photoUrl,
    this.status,
    this.email,
    this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      status: map['status'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
