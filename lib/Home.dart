import 'package:flutter/material.dart';

import 'Screens/SignInOne.dart';
import 'Screens/SignInTwo.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SignInOne(),
//    body: SignInTwo(), 
    );
  }
}
