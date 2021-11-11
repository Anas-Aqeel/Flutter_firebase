import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/home/widgets/drawer.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
          child: SingleChildScrollView(child: PostCreate()),
        ),
      ),
    );
  }
}

class PostCreate extends StatefulWidget {
  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  bool isLoading = false;
  String date;
  File _image;
  String imageName;
  String link;
  String username = '${userData["Username"]}';
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
      imageName = path.basename(_image.path);
      print(imageName);
    });
  }

  uploadImage() async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('$imageName');
    await ref.putFile(_image);
    link = await ref.getDownloadURL();
    setState(() {});
  }

  getDate() {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('MMMM d').format(now);
    String currentTime = DateFormat.jm().format(now);
    setState(() {
      date = '$currentDate at $currentTime';
    });
    print(date);
  }

  uploadPost() async {
    setState(() {
      isLoading = true;
    });
    await uploadImage();
    getDate();
    FirebaseFirestore db = FirebaseFirestore.instance;
    var collPost = await db.collection('post').add({
      'date': date,
      'description': '${description.text}',
      'image': '$link',
      'title': '${title.text}',
      'user': "$username",
      'writerId': '${user.uid}'
    });
    await db
        .collection('user')
        .doc(user.uid)
        .collection('posts')
        .doc(collPost.id)
        .set({
      'date': date,
      'description': '${description.text}',
      'image': '$link',
      'title': '${title.text}',
      'user': "$username"
    });
    isLoading = false;
    Navigator.pushNamed(context, '/home');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 3.0,
            ),
          )
        : Container(
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey[500]),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  tileColor: Colors.grey[100],
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/images.png'),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$username',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          Text(
                            '31 July at 10:57 AM',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.account_circle_rounded,
                            color: Colors.black54,
                            size: 20,
                          )
                        ],
                      )
                    ],
                  ),
                  trailing: Icon(Icons.close),
                ),
                _image == null
                    ? GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 350,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                                color: Colors.grey[700],
                              ),
                              SizedBox(height: 10),
                              Text('Upload an image')
                            ],
                          ),
                        ),
                      )
                    : Image.file(
                        _image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        hintText: 'Enter Title'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        hintText: 'Enter description'),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: MaterialButton(
                    // shape: StadiumBorder(),
                    height: 45,
                    minWidth: double.infinity,
                    color: Colors.black54,
                    onPressed: uploadPost,
                    child: Text(
                      'Upload post',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
