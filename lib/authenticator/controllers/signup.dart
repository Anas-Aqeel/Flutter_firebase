import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

dynamic signup(
    String email, String password, String cpassword, String username) async {
  if (password == cpassword) {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      var client = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await db
          .collection("user")
          .doc(client.user.uid)
          .collection('userdata')
          .doc(client.user.uid)
          .set({"Username": '$username', "Email": '${client.user.email}'});

      DocumentSnapshot snapshot =
          await db.collection("user").doc(client.user.uid).get();

      userData = snapshot.data();
      user = client.user;

      print('$user');
      print('$userData');

      return true;
    } catch (e) {
      print('the Error is');

      return false;
    }
  } else {
    print('passsword mismatch');

    return false;
  }
}
