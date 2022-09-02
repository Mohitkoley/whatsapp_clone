// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;
  UserModel({
    required this.phoneNumber,
    required this.groupId,
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      uid: json["uid"] ?? "",
      profilePic: json["profilePic"] ?? "",
      isOnline: json["isOnline"] ?? false,
      phoneNumber: json["phoneNumber"] ?? "",
      groupId: List.from(json["groupId"]),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'PhoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }
}
