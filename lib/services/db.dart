import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'models.dart';

class DbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// gets signed-in user's writeups
  Future<List<Writeup>> getUserWriteUps() async {
    final List<Writeup> writeups = [];
    try {
      final AuthService authService = AuthService();
      final String uid = authService.getUser!.uid;

      final response = await _db
          .collection('writeUps')
          .where('uid', isEqualTo: uid)
          .orderBy('dateCreated', descending: true)
          .get();

      List<Writeup> writeups = [];

      if (response.size > 0) {
        writeups.addAll(response.docs
            .map(
              (DocumentSnapshot doc) => Writeup.fromFirestore(doc),
            )
            .toList());
      }
      return writeups;
    } catch (e) {
      print(e.toString());
      return writeups;
    }
  }

  /// actively listens to the writeUps collection in Firestore
  Stream<QuerySnapshot> getWriteUpsStream() {
    return _db
        .collection('writeUps')
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  /// creates a new writeup
  Future<void> createEntry(Writeup writeup) {
    final AuthService authService = AuthService();

    // add currently logged in user's uid to the writeup if it exists
    if (authService.getUser != null) {
      writeup.uid = authService.getUser!.uid;
    }

    return _db.collection('writeUps').add(writeup.toMap()).then((documentRef) {
      print(documentRef.id);
    });
  }

  /// deletes writeup by id
  Future<void> deleteEntry(String? writeupId) {
    return _db.collection('writeUps').doc(writeupId).delete();
  }

  Future<void> updateProfile(AppUser user) async {
    return _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
    }, SetOptions(merge: true));
  }
}
