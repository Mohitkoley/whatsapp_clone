// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String PhoneNumber;
  final List<String> groupId;
  UserModel({
    required this.PhoneNumber,
    required this.groupId,
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      PhoneNumber: json['PhoneNumber'] ?? '',
      groupId: json['groupId'] ?? '',
      name: json['name'] ?? '',
      uid: json['uid'] ?? '',
      profilePic: json['profilePic'] ?? '',
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'uid': uid,
        'profilePic': profilePic,
        'isOnline': isOnline,
        'PhoneNumber': PhoneNumber,
        'groupId': groupId,
      };
}
