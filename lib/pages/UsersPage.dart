import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/User.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final users = [
    User(uid: '1', nombre: 'María', email: 'test1@test.com', online: true),
    User(uid: '2', nombre: 'Melissa', email: 'test2@test.com', online: false),
    User(uid: '3', nombre: 'Fernando', email: 'test3@test.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My name', style: TextStyle(color: Colors.black54)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black54),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.check_circle_outline, color: Colors.green),
              // Icon(Icons.Icons.error_outline, color: Colors.red)
            )
          ],
        ),
        body: SmartRefresher(
            controller: _refreshController,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.blue[400]),
              waterDropColor: Colors.blue[400],
            ),
            enablePullDown: true,
            onRefresh: _loadUser,
            child: _usersListView()));
  }

  ListView _usersListView() {
    return ListView.separated(
        itemBuilder: (_, index) => _userListTile(users[index]),
        separatorBuilder: (_, index) => Divider(),
        itemCount: users.length,
        physics: BouncingScrollPhysics());
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
          child: Text(user.nombre.substring(0, 2)),
          backgroundColor: Colors.blue[200]),
      trailing: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
              color: user.online ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10.0))),
    );
  }

  _loadUser() async {
    await Future.delayed(Duration(milliseconds: 800));
    _refreshController.refreshCompleted();
  }
}
