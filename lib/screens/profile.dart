import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/services.dart';
import '../shared/writeup_item.dart';
import 'login.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';

  ProfileScreen({Key? key}) : super(key: key);

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Writer!'),
        actions: [
          TextButton(
            child: const Text('Log Out'),
            onPressed: () {
              AuthService authService = AuthService();
              authService.signOut().then((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (route) => false);
              });
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Writeup>>(
          future: _dbService.getUserWriteUps(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      WriteUpItem(snapshot.data![index]),
                );
              } else {
                return const Center(
                  child: Text(
                    'No WriteUps found!',
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
