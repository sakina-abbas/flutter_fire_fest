import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String uid, name, email;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    final AppUser user = AppUser(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );

    return user;
  }

  Map<String, dynamic> toMap() {

    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}

class Writeup {
  String? id;
  String? uid;
  String title;
  String body;
  DateTime? dateCreated;

  Writeup({this.id, this.uid, required this.title, required this.body, this.dateCreated});

  factory Writeup.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Writeup(
      id: snapshot.id,
      uid: data['uid'] ?? '',
      title: data['title'] ?? '',
      body: data['body'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'body': body,
      'dateCreated': dateCreated,
    };
  }
}
