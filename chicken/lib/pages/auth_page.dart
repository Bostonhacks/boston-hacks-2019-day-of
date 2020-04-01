import 'package:flutter/material.dart';
import 'package:chicken/containers/auth_button_container.dart';

class AuthPage extends StatelessWidget {
    // We passed it a title from the app root, so we have to
    // set up the class to accept that arg.

  AuthPage();

  @override
  Widget build(BuildContext context) {
    // Scaffold is almost always going to be your top-level widget
    // on each page.
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        child: new Center (child: new Column (mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
							new GoogleAuthButtonContainer(),	]),)
      ),
    );
  }
}