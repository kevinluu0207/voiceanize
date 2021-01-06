import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login/authService.dart';
import 'Login/wrapper.dart';
import 'Login/user.dart';
import 'alanAI.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AlanAI alanAI = new AlanAI();
  Widget build(BuildContext context) {
    alanAI.initAlanButton();
    return StreamProvider<User>.value(
      value: AuthService().user,
      child:GestureDetector(
        onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(alanAI)
        )
      )
    );
  }
}

