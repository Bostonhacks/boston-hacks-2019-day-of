import 'package:flutter/material.dart';
import 'package:chicken/containers/auth_button_container.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size;
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            alignment: Alignment.center,
            width: pageSize.width,
            height: pageSize.height,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.2, 1.0],
                colors: [
                  const Color(0xFFFAFAFA),
                  const Color(0xFFFAFAFA),
                ],
              ),
            ),
            child: new Container(
              height: 400.0,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 128.0),
                    child: new GoogleAuthButtonContainer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}