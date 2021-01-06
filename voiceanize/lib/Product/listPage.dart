import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'previewProduct.dart';
import 'item.dart';
import 'addProduct.dart';
import 'check.dart';
import 'package:voiceanize/alanAI.dart';

class ListPage extends StatefulWidget {
  final AlanAI alanAI;
  final String searchVal;
  final _ListPageState _listPageState = new _ListPageState();
  
  ListPage(this.alanAI, this.searchVal){
    alanAI.resetButton();
    alanAI.page = _listPageState;
  }

  _ListPageState createState() => _listPageState;
}

class _ListPageState extends State<ListPage> {
  List<Item> items;

  Widget build(BuildContext context) {
    widget.alanAI.context = context;
    widget.alanAI.setVisuals('listPage', null);
    items = Provider.of<List<Item>>(context) ?? [];
    print(items);
    List<Item> display = [];
    if(widget.searchVal != '') {
      for (Item item in items) {
        if (item.name.toLowerCase().contains(widget.searchVal.toLowerCase()) || item.category.toLowerCase().contains(widget.searchVal.toLowerCase()))
          display.add(item);
      }
    }
    else {
      display = items;
    }
    return ListView.builder(
      itemCount: display.length + 1,
      itemBuilder: (context, index) {
        if (index == display.length)
          return ItemTile(null, widget.alanAI);
        else
          return ItemTile(display[index], widget.alanAI,);
      }
    ); 
  }

  Item getItem(String name) {
    for(Item item in items) {
      if (item.name.toLowerCase() == name.toLowerCase())
        return item;
    }
    return null;
  }

  void search() {
    setState((){});
  }
}

class ItemTile extends StatelessWidget{
  final Item item;
  final AlanAI alanAI;
  final Check check = new Check();

  ItemTile(this.item, this.alanAI);
  
  Widget build(BuildContext context) {
    print(item);
    if(item != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PreviewProduct(item, alanAI)), (Route<dynamic> route) => false);
            },
            leading: Container(
              child: ClipOval(
                child: Image.network(
                  item.url == '' ? 'https://www.publicdomainpictures.net/pictures/30000/nahled/plain-white-background.jpg' : item.url,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(item.name),
            subtitle: check.isInt(item.price) ? Text(item.category + "\n\$" + (item.price.toInt().toString())) : Text(item.category + "\n\$" + (item.price.toString())),
            trailing: IconButton(
              icon: Icon(Icons.close,
                color: Colors.red,
                size: 30.0
              ),
              onPressed: () {
                item.verifyDelete(context, alanAI);
              },
            ) 
          ),
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AddProduct(alanAI)), (Route<dynamic> route) => false);
            },
            leading: Icon(Icons.add,
              color: Colors.blue,
              size: 30.0
            ),
            title: Text('Add Item')
          ),
        ),
      );
    }
  }


}


