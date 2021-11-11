// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:firebase_crud/home/widgets/drawer.dart';
import 'package:firebase_crud/home/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPost extends StatefulWidget {
  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  // FirebaseFirestore db = FirebaseFirestore.instance;

  Stream collectionStream =
      FirebaseFirestore.instance.collection('post').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: collectionStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 3.0,
                    ),
                  );
                } else {
                  return new Column(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();
                      
                      return new Post(
                        source: 'collection',
                        id: document.id,
                        data: data,
                        isAdmin: data['writerId'] == user.uid,
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
