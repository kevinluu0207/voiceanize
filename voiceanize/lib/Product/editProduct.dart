import 'package:flutter/material.dart';

import 'package:voiceanize/Product/databaseService.dart';
import 'package:voiceanize/Product/previewProduct.dart';
import 'package:voiceanize/sharedWidgets.dart';
import 'item.dart';
import 'package:voiceanize/Product/listHome.dart';
import 'check.dart';
import 'databaseService.dart';
import 'newItem.dart';
import 'package:voiceanize/alanAI.dart';

class EditProduct extends StatefulWidget {
  final Item item;
  final AlanAI alanAI;
  final NewItem newItem = new NewItem();

  final _EditProductState editProductState = new _EditProductState();

  EditProduct(this.item, this.alanAI) {
    newItem.editItemFormat(item);
    alanAI.page = editProductState;
  }

  _EditProductState createState() => editProductState;
}

class _EditProductState extends State<EditProduct> {
  final formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  String nameValidator = '';
  Check check = new Check();
  Item item;
  NewItem newItem;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    newItem = widget.newItem;
    widget.alanAI.newItem = newItem;
    widget.alanAI.context = context;
    widget.alanAI.setVisuals('editPage', null);
    double dWidth = MediaQuery.of(context).size.width;
    double dHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.white, Colors.white])),
            child: Stack(
              children: <Widget>[
                Column(children: <Widget>[
                  GradientBlock(dWidth / 1.23, dWidth / 1.23, item.url, 0.5),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25.0),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Column(
                            children: <Widget>[
                              TextGradient("Name"),
                              GradientField(
                              item.name, 
                              newItem.nameController, 
                              null, 
                              (val) {newItem.name = val;}
                              ),

                              SizedBox(height: 10),
                              TextGradient("Price"),
                              GradientField( 
                              check.isInt(item.price) ? (item.price == 0 ? 'Price' : item.price.toInt().toString()): item.price.toString(),
                              newItem.priceController,
                              (val) => (check.isDouble(val) || val.trim() == '') ? null : 'Invalid Price',
                              (val) {newItem.price = val;} 
                              ),

                              SizedBox(height: 10),
                              TextGradient("Category"),
                              GradientField(
                              item.category == '' ? 'Category' : item.category, 
                              newItem.categoryController, 
                              null, 
                              (val) {newItem.category = val;}
                              ),   

                              SizedBox(height: 10),
                              TextGradient("Aisle"),
                              GradientField(
                              item.aisle == '' ? 'Aisle' : item.aisle, 
                              newItem.aisleController, 
                              null, 
                              (val) {newItem.aisle = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Quantity"),
                              GradientField(
                              check.isInt(item.quantity) ? (item.quantity == 0 ? 'Quantity' : item.quantity.toInt().toString()): item.quantity.toString(), 
                              newItem.quantityController, 
                              (val) => (check.isDouble(val) || val.trim() == '') ? null : 'Invalid Quantity', 
                              (val) {newItem.quantity = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Image URL"),
                              GradientField(
                              item.url == '' ? 'URL' : item.url, 
                              null, 
                              (val) => (check.isImageURL(val) || val.trim() == '') ? null : 'Invalid Image URL', 
                              (val) {newItem.url = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Notes"),
                              GradientField(
                              item.notes == '' ? 'Notes' : item.notes, 
                              newItem.notesController, 
                              null, 
                              (val) {newItem.notes = val;}
                              ),
                              
                              SizedBox(height: 25),
                              RaisedButton(
                                color: Colors.blue[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  editSubmit(newItem);
                                }
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              Column(children: <Widget>[
                Column(children: <Widget>[

                    SizedBox(height: dHeight * 0.05),
                    GradientIcon(Icons.home,  () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHome(widget.alanAI)), (Route<dynamic> route) => false);}),
                    
                    SizedBox(height: dHeight * 0.05),
                    GradientIcon(Icons.remove_red_eye, () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PreviewProduct(item, widget.alanAI)), (Route<dynamic> route) => false);}),
                  ])
              ]),
            ],
          )
        ),
      ),
    );
  }

  Future<bool> editSubmit(NewItem newItem) async {
    newItem.formatEdit();
    var response = await databaseService.checkDupName(newItem.name); 
    setState(() {
      this.nameValidator = response;
    });
    if (formKey.currentState.validate()) {
      await DatabaseService().editItemData(newItem);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHome(widget.alanAI)), (Route<dynamic> route) => false);
      return true;
    }
    return false;
  }
}
