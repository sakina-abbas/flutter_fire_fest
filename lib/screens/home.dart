import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'screens.dart' show NewWriteUpScreen;
import '../services/services.dart';
import '../shared/writeup_item.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PenPal'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewWriteUpScreen.id),
        child: const Icon(Icons.edit),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _dbService.getWriteUpsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final List<Writeup> writeUps = snapshot.data!.docs
                    .map(
                      (DocumentSnapshot doc) => Writeup.fromFirestore(doc),
                    )
                    .toList();
                return ListView.builder(
                  itemCount: writeUps.length,
                  itemBuilder: (BuildContext context, int index) =>
                      WriteUpItem(writeUps[index]),
                );
              } else {
                return const Center(
                  child: Text(
                    'No Writeups found!',
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
//      body: ListView.builder(
//        itemCount: Globals.testWriteUps.length,
//        itemBuilder: (BuildContext context, int index) =>
//            WriteUpItem(Globals.testWriteUps[index]),
//      ),
    );
  }
}
