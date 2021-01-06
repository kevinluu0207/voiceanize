import 'package:flutter/material.dart';

import 'package:voiceanize/sharedWidgets.dart';
import 'package:voiceanize/alanAI.dart';
import 'commands.dart';
import 'authService.dart';

class Home extends StatefulWidget {
  final AlanAI alanAI;

  Home(this.alanAI);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  Widget build(BuildContext context) {
    double dHeight = MediaQuery.of(context).size.height;
    double dWidth = MediaQuery.of(context).size.width;
    
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: dHeight * 0.2),
                child: Text(
                  'Welcome to Voiceanize',
                  style: TextStyle(
                    shadows: [Shadow(blurRadius: 15.0, color: Colors.black,)],
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: 'Google Sans'
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: dHeight * 0.06, left: dWidth * 0.067, right: dWidth * 0.067),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter an email.' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                      ),
                        
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long.' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                      ),
                      SizedBox(height: 12.0),
                      Text(error, style:TextStyle(color: Colors.red, fontSize:14.0))
                    ]
                  )
                )
              ),
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: dWidth * 0.1),
                    child: SizedBox( 
                      height: dHeight * 0.08,
                      width: dWidth * 0.35,
                      child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text('Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () async {       
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.signInEP(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Couldn\'t find account.';
                                loading = false;
                              });
                            }
                          }
                        }
                      )
                    )
                  ),    

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: dWidth * 0.1),
                    child: SizedBox( 
                      height: dHeight * 0.08,
                      width: dWidth * 0.35,
                      child: RaisedButton(
                        color: Colors.blue[400],
                        child: Text('Register',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        onPressed: () async { 
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerEP(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply a valid email.';
                                loading = false;
                                });
                            }
                          }
                        }
                      )
                    )
                  ),    
                ],
              ),
              

              

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: dHeight * 0.03, left: dWidth * 0.1, right: dWidth * 0.1),
                child: SizedBox( 
                  height: dHeight * 0.08,
                  width: dWidth * 0.8,
                  child: RaisedButton(
                    color: Colors.blue[400],
                    child: Text('Commands',
                      style: TextStyle(color: Colors.white, fontSize: 25), 
                    ),
                    onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Commands())) },
                  )
                )
              ),

            ])
          ],
        ),
      ),
    );
  }
}