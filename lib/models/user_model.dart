import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String hostel;
  final String roomNumber;
  final String phoneNumber;
  final List pools;
  final List userPools;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.hostel,
      required this.roomNumber,
      required this.phoneNumber,
      required this.pools,
      required this.userPools});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      hostel: snapshot["hostel"],
      roomNumber: snapshot["roomNumber"],
      phoneNumber: snapshot["phoneNumber"],
      pools: snapshot["pools"],
      userPools: snapshot["userPools"]
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "hostel": hostel,
        "roomNumber": roomNumber,
        "phoneNumber": phoneNumber,
        "pools": pools,
        "userPools": userPools,
      };
}
