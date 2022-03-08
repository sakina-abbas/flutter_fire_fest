import 'package:flutter/material.dart';
import '../services/services.dart';

class NewWriteUpScreen extends StatelessWidget {
  static String id = 'new_writeup_screen';

  NewWriteUpScreen({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('What will you write today?'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              if (_titleController.text.isNotEmpty &&
                  _bodyController.text.isNotEmpty) {
                Writeup writeup = Writeup(
                  title: _titleController.text,
                  body: _bodyController.text,
                  dateCreated: DateTime.now(),
                );

                DbService dbService = DbService();
                await dbService.createEntry(writeup);
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            TextField(
              controller: _bodyController,
              maxLength: 100,
              maxLines: 20,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Write away!",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
