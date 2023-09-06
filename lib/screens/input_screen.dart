import 'package:flutter/material.dart';
import 'package:myfeedapp/database/db.dart';

class InputScreen extends StatefulWidget {
  static const String id = 'HomeScreen';
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = '';
    descriptionController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              getdata();
            },
            child: const Text('Add Data'),
          ),
        ],
      ),
    );
  }

  void getdata() {
    final title = titleController.text;
    final des = descriptionController.text;
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Fill in all fields')));
      return;
    }
    createUser(name: title, description: des);
    titleController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }
}
