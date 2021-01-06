import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user.dart';
import 'home.dart';
import 'package:voiceanize/alanAI.dart';
import 'package:voiceanize/Product/listHome.dart';

class Wrapper extends StatelessWidget {
  final AlanAI alanAI;

  Wrapper(this.alanAI);

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    if  (user == null) {
      alanAI.context = context;
      alanAI.setVisuals('null', 'null');
      return Home(alanAI);
    } 
    else
     {
      return ListHome(alanAI);
    } 
  }
}
