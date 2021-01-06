import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'item.dart';
import 'package:voiceanize/sharedWidgets.dart';
import 'editProduct.dart';
import 'package:voiceanize/alanAI.dart';
import 'listHome.dart';

class PreviewProduct extends StatefulWidget {
  final Item item;
  final AlanAI alanAI;
  _PreviewProductState previewProductState;

  PreviewProduct(this.item, this.alanAI) {
    previewProductState = _PreviewProductState(item);
    alanAI.page = previewProductState;
  }

  _PreviewProductState createState() => previewProductState;
}

class _PreviewProductState extends State<PreviewProduct> {
  Item item;

  _PreviewProductState(this.item);

  Widget build(BuildContext context) {
    widget.alanAI.context = context;
    widget.alanAI.setVisuals('previewPage', null);
    double dWidth = MediaQuery.of(context).size.width;
    double dHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.white, Colors.white])),
          ),
          Column(children: <Widget>[
            SizedBox(height: dHeight * 0.05),
            GradientIcon(Icons.home, () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHome(widget.alanAI)), (Route<dynamic> route) => false);}),

            SizedBox(height: dHeight * 0.05),
            GradientIcon(Icons.edit, () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EditProduct(item, widget.alanAI)), (Route<dynamic> route) => false);}),
                      
            SizedBox(height: dHeight * 0.05),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: dWidth * 0.025),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(-2, 2))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Color(0xff759eff), Color(0xff75e1ff)]
                    )
                  ),
                  child: IconButton(
                    padding: EdgeInsets.only(top: 0, left: 0),
                    icon: Icon(Icons.info),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: () { prompt(context, item); }
                  )
                ),
              ),
            )
          ]),
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GradientBlock(dWidth/1.23, dWidth/1.23, item.url, 0.5),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          left: dWidth * 0.05, top: dHeight * 0.05),
                      child:
                          GradientTile(item, item.name, 50)),
                  Container(
                    padding: EdgeInsets.only(left: dWidth * 0.03),
                    child: RatingBar(
                      initialRating: 4.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: dWidth * 0.05, top: dHeight * 0.02),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GradientTile(item, item.category, 25),
                            Text(" | ", style: TextStyle(fontSize: 25)),
                            GradientTile(item, "Aisle: " + item.aisle, 25),
                          ],
                        ),
                        SizedBox(height: dHeight * 0.01),
                        GradientTile(item, "Quantity: " + item.quantity.toString(), 25),
                        SizedBox(height: dHeight * 0.01),
                        SizedBox(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              GradientTile(item, "Notes: " + item.notes, 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
              right: 80,
              bottom: dWidth * 0.03,
              child: GradientTile(item, "\$" + item.price.toString(), 50)),
          Positioned(
            left: dWidth * 0.03,
            bottom: dWidth * 0.04,
            child: GradientIcon(Icons.shopping_cart, () { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ListHome(widget.alanAI)), (Route<dynamic> route) => false); }),
          ),
        ],
      ),
    );
  }
}
