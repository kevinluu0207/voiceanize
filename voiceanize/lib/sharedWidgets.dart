import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_text/gradient_text.dart';
import 'Product/item.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  )
);

class Loading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}

class GradientTile extends StatelessWidget {
  final Item item;
  final String text;
  final double size;

  GradientTile(this.item, this.text, this.size);

  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GradientText(text,
              gradient: LinearGradient(colors: [Colors.black, Colors.black]),
              style: TextStyle(
                  fontSize: size,
                  fontFamily: 'Google Sans',
                  fontWeight: FontWeight.bold)),
        ]);
  }
}

class TextInput extends StatefulWidget {
  final Item item;
  final String hint;
  TextInput(this.item, this.hint);
  
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String result = "";

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
          hintText: widget.hint,
        ),
        onSubmitted: (String str) {
          setState(() {
            result = str;
          });
        },
      ),
      Text(result),
    ]);
  }
}

class TextGradient extends StatelessWidget {
  final String text;
  TextGradient(this.text);

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: GradientText(text + ": ",
          gradient:
              LinearGradient(colors: [Color(0xff759eff), Color(0xff75e1ff)]),
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'Google Sans',
              fontWeight: FontWeight.bold)),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String buttonText;
  final function;
  GradientButton(this.buttonText, this.function);
  
  Widget build(BuildContext context) {
    double dWidth = MediaQuery.of(context).size.width;
    double dHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(5),
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.all(0),
          onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => function)) },
          child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [(Color(0xff3892FF)), (Color(0xff67D3FF))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: dWidth * 0.4, minHeight: dHeight * 0.08),
                alignment: Alignment.center,
                child: Text(buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Google Sans',
                      fontSize: 25,
                    )),
              ))),
    );
  }
}

Future<void> prompt(context, item) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Notes: ", style: TextStyle(fontSize: 25, fontFamily: 'Google Sans', fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(child: Text(item.notes, style: TextStyle(fontSize: 20, fontFamily: 'Google Sans'))
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Exit', style: TextStyle(fontSize: 20, fontFamily: 'Google Sans')),
              onPressed: () async {
                Navigator.of(context).pop();
                
              },
            ),
          ],
        );
      },
    );
  }

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final Function function;
  GradientIcon(this.icon, this.function);

  Widget build(BuildContext context) {
    double dWidth = MediaQuery.of(context).size.width;
    return Container(
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
            icon: Icon(icon),
            color: Colors.white,
            iconSize: 35,
            onPressed: function,
          )
        ),
      ),
    );
  }
}

class GradientBlock extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double opacity;
  GradientBlock(this.width, this.height, this.url, this.opacity);

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xff759eff), Color(0xff75e1ff)]),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(opacity),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(0, 2))
            ]),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Image(image: NetworkImage(url))),
      ),
    );
  }
}

class GradientField extends StatelessWidget {
  final String hintText;
  final String Function(String) validator;
  final void Function(String) function;
  final TextEditingController controller;
  GradientField(this.hintText, this.controller, this.validator, this.function);

  Widget build(BuildContext context) {
    return Stack(
          children: <Widget> [
          Container(
            height: 50,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(-2, 2))
            ],
            borderRadius: BorderRadius.all(Radius.circular(50)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xff759eff), Color(0xff75e1ff)])),
                ),
        TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: InputBorder.none,
                hintText: hintText),
            validator: validator,
            onChanged: function),

    ]);
  }
}