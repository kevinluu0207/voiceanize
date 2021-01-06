import 'package:flutter/material.dart';
import 'databaseService.dart';
import 'package:voiceanize/alanAI.dart';

class Item {
  final String name;
  final String category;
  final String aisle;
  final double quantity;
  final double price;
  final String url;
  final String notes;
  final String uid;

  Item( this.name, this.category, this.aisle, this.quantity, this.price, this.url, this.notes, this.uid,);

  Future<void> verifyDelete(BuildContext context, AlanAI alanAI) async {
    alanAI.setVisuals('listPage', 'verifyDelete');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Would you like to delete this item?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await DatabaseService().deleteItemData(uid);
                alanAI.setVisuals('listPage', null);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                alanAI.setVisuals('listPage', null);
              },
            ),
          ],
        );
      },
    );
  }
}