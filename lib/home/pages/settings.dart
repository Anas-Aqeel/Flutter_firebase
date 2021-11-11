import 'package:firebase_crud/home/widgets/drawer.dart';
import 'package:flutter/material.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Accounts'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Notification');
              },
              icon: Icon(Icons.notifications),
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 260,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 220,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 30,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(height: 10),
                                Text('Add a cover photo'),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 100,
                          right: 100,
                          child: Container(
                            child: CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.edit_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                              backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/photos/portrait-of-smiling-handsome-man-in-blue-tshirt-standing-with-crossed-picture-id1045886560?k=6&m=1045886560&s=612x612&w=0&h=hXrxai1QKrfdqWdORI4TZ-M0ceCVakt4o6532vHaS3I='),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customise your Intro',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    content: DialogContent(),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("okay"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text('Edit'))
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    ListTile(
                      tileColor: Colors.grey[100],
                      leading: Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      title: Text('Anas Aqeel'),
                    ),
                    ListTile(
                      tileColor: Colors.grey[100],
                      leading: Container(
                        child: Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.red[800],
                        ),
                      ),
                      title: Text('anasaqeel.5555@gmail.com'),
                    ),
                    ListTile(
                      tileColor: Colors.grey[100],
                      leading: Container(
                        child: Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.green[400],
                        ),
                      ),
                      title: Text('+923342233619'),
                    ),
                    ListTile(
                      tileColor: Colors.grey[100],
                      leading: Container(
                        child: Icon(
                          Icons.home,
                          size: 25,
                          color: Colors.brown[700],
                        ),
                      ),
                      title: Text('Home town'),
                    ),
                    ListTile(
                      tileColor: Colors.grey[100],
                      leading: Container(
                        child: Icon(
                          Icons.school,
                          color: Colors.blueGrey[800],
                          size: 25,
                        ),
                      ),
                      title: Text('School or university'),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MaterialButton(
                        // shape: StadiumBorder(),
                        height: 45,
                        minWidth: double.infinity,
                        color: Colors.black54,
                        onPressed: () {},
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogContent extends StatefulWidget {
  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SizedBox(), Text('Edit profile'), Icon(Icons.close)],
          ),
          Divider(),
          SizedBox(height: 15),
          Text(
            'Profile picture',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(height: 25),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[100],
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Cover Photo',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(height: 25),
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.grey[100],
          ),
          SizedBox(height: 30),
          Text(
            'Customise your Intro',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(height: 25),
          TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            decoration: InputDecoration(
                hintText: 'Hello23',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                )),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            decoration: InputDecoration(
                hintText: 'example@gmail.com',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.red[800],
                )),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            decoration: InputDecoration(
                hintText: '+1234567890',
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.green[400],
                )),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            decoration: InputDecoration(
                hintText: 'Karachi, Pakistan',
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.brown[700],
                )),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            decoration: InputDecoration(
                hintText: 'School or university',
                prefixIcon: Icon(
                  Icons.school,
                  color: Colors.blueGrey[800],
                )),
          ),
        ],
      ),
    );
  }
}
