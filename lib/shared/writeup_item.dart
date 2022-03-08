import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/db.dart';
import '../services/models.dart';

class WriteUpItem extends StatelessWidget {
  final DbService _dbService = DbService();
  final AuthService _authService = AuthService();
  final Writeup writeup;

  WriteUpItem(this.writeup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF6ebfc2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    writeup.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                if (writeup.uid == _authService.getUser!.uid)
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      print(result);

                      switch(result) {
                        case 'edit':
                          break;
                        case 'delete':
                          _dbService.deleteEntry(writeup.id);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  )
//                  IconButton(
//                    icon: const Icon(Icons.more_vert),
//                    onPressed: () {
//                    },
//                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Align(
                  alignment: Alignment.topLeft, child: Text(writeup.body)),
            ),
          ],
        ),
      ),
    );
  }
}
