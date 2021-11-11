import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

dynamic signin(String email, String password) async {
  try {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential client = await auth.signInWithEmailAndPassword(
        email: email, password: password);
    DocumentSnapshot snapshot =
          await db.collection("user").doc(client.user.uid)
          .collection('userdata')
          .doc(client.user.uid)
          .get();

      user = client.user;
      userData = snapshot.data();

    print('User');
    print('$user');
    print('UserData');
    print('$userData');

    return true;
  } catch (e) {
    print('the Error is');
    print(e);

    return false;
  }
}
