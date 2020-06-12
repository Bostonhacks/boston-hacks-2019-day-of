import 'package:flutter/material.dart';
import 'package:chicken/constants/colors.dart';
import 'package:chicken/containers/auth_button/toolbar_button_signout_container.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: MeSuiteColors.blue,
          automaticallyImplyLeading: false,
          title: new Text(this.title),
          actions: [
            new ToolbarLogOutButton(),
          ]),
      body: new Container(),
    );
  }
}
