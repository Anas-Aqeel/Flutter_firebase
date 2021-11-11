import 'package:firebase_crud/home/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final Map data;
  final id;
  final source;
  final isAdmin;
  const Post({this.data, this.id, this.source, this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    '${data["user"]}',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Row(
                    children: [
                      Text(
                        '${data["date"]}',
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
              trailing: BottomNavBarState(
                id: id,
                data: data,
                source: source,
                showAdminControlls: isAdmin,
              )),
          Image.network(
            '${data["image"]}',
            // height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${data["title"]}',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${data["description"]}',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
