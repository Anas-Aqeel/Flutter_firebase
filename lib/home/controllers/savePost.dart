import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';


savePost(String id, Map<String, dynamic> data) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(user.uid)
      .collection('saveposts')
      .doc(id)
      .set(data);
  print('Post Saved ');
}

unSavePost(String id) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(user.uid)
      .collection('saveposts')
      .doc(id)
      .delete();
  print('Post Removed ');
}
