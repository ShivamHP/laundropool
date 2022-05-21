import 'package:cloud_firestore/cloud_firestore.dart';

class Pool {
  final String uid;
  final String creator;
  final String bio;
  final Map<String, int> participants;
  final int available_space;
  final int total_space;
  final String laundary_service;
  final int day_of_month;
  final int month;
  final int year;
  final int price;

  const Pool(
      {required this.uid,
      required this.bio,
      required this.creator,
      required this.available_space,
      required this.total_space,
      required this.laundary_service,
      required this.day_of_month,
      required this.month,
      required this.participants,
      required this.year,
      required this.price});

  static Pool fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Pool(
      uid: snapshot["uid"],
      bio: snapshot["bio"],
      creator: snapshot["creator"],
      available_space: snapshot["available_space"],
      total_space: snapshot["total_space"],
      laundary_service: snapshot["laundary_service"],
      day_of_month: snapshot["day_of_month"],
      month: snapshot["month"],
      year: snapshot["year"],
      price: snapshot["price"],
      participants: snapshot["participants"]
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "bio": bio,
        "creator": creator,
        "available_space": available_space,
        "total_space": total_space,
        "laundary_service": laundary_service,
        "day_of_month": day_of_month,
        "month": month,
        "year": year,
        "price": price,
        "participants": participants
      };
}
