import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';

updatePost(String id, Map<String, dynamic> data) async {
  print(id);
  await FirebaseFirestore.instance.collection('post').doc(id).update(data);
  await FirebaseFirestore.instance
      .collection('user')
      .doc(user.uid)
      .collection('posts')
      .doc(id)
      .update(data);
}
