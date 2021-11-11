import 'dart:io';
import 'package:firebase_crud/home/controllers/updatePost.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/home/widgets/drawer.dart';
import 'package:firebase_crud/authenticator/authenticator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditPost extends StatefulWidget {
  final Map data;
  final String id;

  EditPost({this.data, this.id});
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
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
              child: PostCreate(data: widget.data, id: widget.id)),
        ),
      ),
    );
  }
}

class PostCreate extends StatefulWidget {
  final Map data;
  final String id;

  PostCreate({this.data, this.id});
  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  bool isLoading = false;
  Map<String, dynamic> data;
  String date;
  File _image;
  String link;
  String imageName;
  String username = '${userData["Username"]}';
  TextEditingController title;
  TextEditingController description;

  Future pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
      imageName = path.basename(_image.path);
      print(imageName);
    });
  }

  uploadImage() async {
    if (_image != null && imageName != null) {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('$imageName');
      await ref.putFile(_image);
      link = await ref.getDownloadURL();
      setState(() {});
    }
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

  setData() {
    data = {
      'date': date,
      'description': '${description.text}',
      'image': link != null ? '$link' : widget.data['image'],
      'title': '${title.text}',
      'user': "$username",
      'writerId': '${user.uid}'
    };
  }

  uploadPost() async {
    setState(() {
      isLoading = true;
    });
    await uploadImage();
    getDate();
    setData();
    await updatePost(widget.id, data);
    isLoading = false;
    Navigator.pushNamed(context, '/home');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    title = TextEditingController(text: '${widget.data['title']}');
    description = TextEditingController(text: '${widget.data['description']}');
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
                            '${widget.data['date']}',
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
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            // image: DecorationImage(
                            //     image:
                            //         NetworkImage('${widget.data["image"]}'),
                            //     fit: BoxFit.cover)
                          ),
                          height: 250,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined,
                                  size: 40, color: Colors.black),
                              SizedBox(height: 10),
                              Text(
                                'Upload an image',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    // initialValue: '${widget.data['title']}',
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
                    // initialValue: '${widget.data['descripton']}',
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
                      'Publish Post',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
