import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfeedapp/model/model.dart';

Future createUser({required String name, required String description}) async {
  final docuser = FirebaseFirestore.instance.collection('users').doc();
  final user = User(
    id: docuser.id,
    name: name,
    description: description,
  );
  final json = user.toJson();
  await docuser.set(json);
}

Stream<List<User>> readUsers() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
