import 'package:flutter/material.dart';

import 'package:voiceanize/Product/databaseService.dart';
import 'package:voiceanize/sharedWidgets.dart';
import 'package:voiceanize/Product/listHome.dart';
import 'check.dart';
import 'databaseService.dart';
import 'newItem.dart';
import 'package:voiceanize/alanAI.dart';
class AddProduct extends StatefulWidget {
  final _AddProductState addProductState = new _AddProductState();
  final AlanAI alanAI; 

  AddProduct(this.alanAI){ 
    alanAI.page = addProductState;
  }

  _AddProductState createState() => addProductState;
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  Check check = new Check();
  String nameValidator = '';
  NewItem newItem = new NewItem();

  Widget build(BuildContext context) {
    widget.alanAI.newItem = newItem;
    widget.alanAI.context = context;
    widget.alanAI.setVisuals('addPage', 'name');
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
                  GradientBlock(dWidth / 1.23, dWidth / 1.23, 'https://media.discordapp.net/attachments/277288469557018627/741162288777527306/transparent.png', 0.5),
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
                              'Name', 
                              newItem.nameController, 
                              (val) => val.trim() == '' ? 'Invalid Name' : nameValidator, 
                              (val) {newItem.name = val;}
                              ),

                              SizedBox(height: 10),
                              TextGradient("Price"),
                              GradientField( 
                              'Price',
                              newItem.priceController,
                              (val) => (val.trim() == '' || check.isDouble(val)) ? null : 'Invalid Price',
                              (val) {newItem.price = val;} 
                              ),

                              SizedBox(height: 10),
                              TextGradient("Category"),
                              GradientField(
                              'Category', 
                              newItem.categoryController, 
                              null, 
                              (val) {newItem.category = val;}
                              ),   

                              SizedBox(height: 10),
                              TextGradient("Aisle"),
                              GradientField(
                              "Aisle", 
                              newItem.aisleController, 
                              null, 
                              (val) {newItem.aisle = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Quantity"),
                              GradientField(
                              "Quantity", 
                              newItem.quantityController, 
                              (val) => (val.trim() == '' || check.isDouble(val)) ? null : 'Invalid Quantity', 
                              (val) {newItem.quantity = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Image URL"),
                              GradientField(
                              "Image URL", 
                              null, 
                              (val) => (check.isImageURL(val) || val.trim() == '') ? null : 'Invalid Image URL', 
                              (val) {newItem.url = val;}
                              ), 

                              SizedBox(height: 10),
                              TextGradient("Notes"),
                              GradientField(
                              "Notes", 
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
                                  addSubmit();
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
                  ])
              ]),
            ],
          )
        ),
      ),
    );
  }

  Future<bool> addSubmit() async{
    newItem.formatAdd();
    var response = await databaseService.checkDupName(newItem.name); 
    setState(() {
        nameValidator = response;
    });
    if (formKey.currentState.validate()) {
      await DatabaseService().addItemData(newItem);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHome(widget.alanAI)), (Route<dynamic> route) => false);
      return true;
    }
    return false;
  }
}
