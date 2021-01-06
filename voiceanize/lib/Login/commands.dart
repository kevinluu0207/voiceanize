import 'package:flutter/material.dart';
class Commands extends StatefulWidget {
  _CommandsState createState() => _CommandsState();
}

class _CommandsState extends State<Commands> {
  Widget build(BuildContext context) {
    double dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Commands Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Commands',
                style: TextStyle(
                  fontFamily: 'Google Sans',
                  fontSize: dwidth*0.1,
                )
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.fromLTRB(dwidth*0.05, 0, dwidth*0.05, 0),
              child: Text(
                  'Add Item: Brings user to the add product page and asks a series of questions about the product. \nEdit (Item): Brings user to the edit item page for the specified item. \nPreview (Item): Brings user to the edit item page for the specified item. \nEdit Mode: Brings user from the edit page to the preview page. \nPreview Mode: Brings user from the preview page to the edit page. \nChange (Property) To (New Property Value): Changes product property value. Can only be used in add or edit page. \nSubmit: Saves changed item info. \nGo Back: Brings user to the list page. \nSearch For (Name/Category): Searches for item name and category. Can only be used in list page. \nDelete (Item): Deletes item. \nYes: Confirm delete. \nNo: Cancel delete. ',
                  style: TextStyle(
                    fontFamily: 'Merriweather-Light',
                    fontSize: dwidth*0.04,
                    height: 1.5,
                  )
              ),

            ),
          ],
        ),
      ),
    );
  }
}