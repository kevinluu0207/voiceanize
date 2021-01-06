import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:voiceanize/Product/databaseService.dart'; 
import 'package:voiceanize/Product/listPage.dart';
import 'package:voiceanize/Product/item.dart';
import '../Login/authService.dart';
import '../Login/wrapper.dart';
import 'package:voiceanize/sharedWidgets.dart';
import 'package:voiceanize/alanAI.dart';

class ListHome extends StatefulWidget {
  final AlanAI alanAI;
  ListHome(this.alanAI);
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  final AuthService _auth = AuthService(); 
  String searchVal = '';
  ListPage listPage;

  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
    value: DatabaseService().items,
    child: Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: TextField(
          controller: widget.alanAI.searchController,
          decoration: textInputDecoration.copyWith(hintText: 'Product/Category', contentPadding: EdgeInsets.all(12.0)),
          onChanged: (val) => {searchVal = val},
          onSubmitted: (val) { setState(() {}); }
        ),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () { setState(() {}); }
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () { verifySignOut(context);
          }
          ),
        ],
        ),
        body: ListPage(widget.alanAI, searchVal)
      ),
    );
  }

   Future<void> verifySignOut(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Would you like to sign out?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context) => Wrapper(widget.alanAI,)), (Route<dynamic> route) => false);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
