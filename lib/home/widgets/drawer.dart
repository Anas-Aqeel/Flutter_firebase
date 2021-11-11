import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({ Key? key }) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/images.png'),
                ),
                accountName: Text('Anas Aqeel'),
                accountEmail: Text('anasaqeel.5555@gmail.com')),
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.post_add),
            title: Text('Create Post'),
            onTap: () {
              Navigator.pushNamed(context, '/createpost');
            },
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.my_library_books),
            title: Text('My Posts'),
            onTap: () {
              Navigator.pushNamed(context, '/userpost');
            },
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.save),
            title: Text('Save Posts'),
            onTap: () {
              Navigator.pushNamed(context, '/savepost');
            },
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            tileColor: Colors.grey[100],
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
