import 'package:flutter/material.dart';
import 'package:chicken/containers/auth_button_container.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/Feliz.png"), height: 300.0),
              SizedBox(height: 50),
              GoogleAuthButtonContainer(),
            ],
          ),
        ),
      ),
    )
    );
  }
}