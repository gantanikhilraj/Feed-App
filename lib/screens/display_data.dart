import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfeedapp/database/db.dart';
import 'package:myfeedapp/model/model.dart';
import 'package:myfeedapp/screens/input_screen.dart';

class DisplayData extends StatefulWidget {
  static const String id = 'DisplayScreen';

  const DisplayData({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          elevation: 0,
          title: const Text('My Feed App'),
        ),
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning, size: 80, color: Colors.red),
                    Text(
                      "No data found",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map((user) => buildUserCard(user)).toList(),
              );
            } else {
              return const Center(
                child: (Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading....."),
                    CircularProgressIndicator(),
                  ],
                )),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, InputScreen.id);
          },
        ),
      ),
    );
  }

  Widget buildUserCard(User user) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            user.name,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            user.description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
            textAlign: TextAlign.start,
          ),
          trailing: IconButton(
            color: Colors.black54,
            icon: const Icon(Icons.delete),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.id)
                  .delete();
            },
          ),
        ),
      );
}
