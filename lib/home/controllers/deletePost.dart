// import 'package:firebase_crud/authenticator/authenticator.dart';
// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';

deletePost(String id) async {
  await FirebaseFirestore.instance.collection('post').doc(id).delete();
  await FirebaseFirestore.instance.collection('user').doc(user.uid).collection('posts').doc(id).delete();
  print('deleted successfully');
}

deletePostFromSave(String id) async {
  await FirebaseFirestore.instance.collection('user').doc(user.uid).collection('save').doc(id).delete();
  print('deleted successfully');
}
