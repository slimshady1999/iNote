import 'package:flutter/material.dart';

import '../../sqlHelper.dart/sqlDB.dart';
import '../../sqlModel.dart/sqlModelClass.dart';
import '../homePage.dart';

class AddNotePage extends StatelessWidget {
  final Note? note;
  const AddNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.title;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(note == null ? "New Note" : "Edit Note"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final title = titleController.value.text;
              final description = descriptionController.value.text;
              if (title.isEmpty || description.isEmpty) {
                return;
              }

              final Note model =
                  Note(title: title, description: description, id: note?.id);

              if (note == null) {
                await DatabaseHelper.createNote(model);
              } else {
                await DatabaseHelper.updateNote(model);
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.title),
                    label: const Text(
                      "Title",
                    ),
                    hintText: "Enter your note title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.purple))),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 100,
                // keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    label: const Text(
                      "Description",
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.purple))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
