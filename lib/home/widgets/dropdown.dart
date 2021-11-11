// import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:firebase_crud/home/controllers/deletePost.dart';
import 'package:firebase_crud/home/controllers/savePost.dart';
import 'package:firebase_crud/home/pages/editPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class BottomNavBarState extends StatefulWidget {
  final source;
  final id;

  final Map data;
  final bool showAdminControlls;

  BottomNavBarState({this.id, this.source, this.data, this.showAdminControlls});

  @override
  _BottomNavBarStateState createState() => _BottomNavBarStateState();
}

class _BottomNavBarStateState extends State<BottomNavBarState> {
  bool condition;
  var text;
  @override
  Widget build(BuildContext context) {
    void postChecker(id) async {
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .collection('saveposts')
          .doc(id)
          .get()
          .then((value) => {
                setState(() {
                  condition = value.data() == null;
                  text = condition ? 'Save' : 'Remove';
                })
              });
    }

    postChecker(widget.id);

    return PopupMenuButton(
        tooltip: 'Menu',
        child: Icon(
          Icons.more_vert,
          size: 28.0,
          color: Colors.black,
        ),
        itemBuilder: (context) => widget.showAdminControlls
            ? [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPost(
                            data: widget.data,
                            id: widget.id,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.yellow[900],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.source == 'save') {
                        deletePostFromSave(widget.id);
                      } else {
                        deletePost(widget.id);
                      }
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () async {
                      if (condition) {
                        Navigator.pop(context);
                        savePost(widget.id, widget.data);
                      } else {
                        Navigator.pop(context);
                        unSavePost(widget.id);
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.save,
                          color: condition ? Colors.green : Colors.redAccent,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Text(
                            '$text',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
  }
}
