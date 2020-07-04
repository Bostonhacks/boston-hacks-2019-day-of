import 'package:flutter/material.dart';
import 'package:chicken/containers/auth_button_container.dart';

class LoggedOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size;
    return new WillPopScope(
    onWillPop: () async => false,
    child:Scaffold(
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
                colors: [
                  const Color(0xFFFAFAFA),
                  const Color(0xFFFAFAFA),
                ],
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  SizedBox(height: 16.0),
                  Image(image: AssetImage("assets/Feliz.png"), height: 300.0),
            SizedBox(height: 16.0),
            Text(
                  'Logged Out',
                  style: Theme.of(context).textTheme.headline,
                  ),
                   SizedBox(height: 16.0),
                   GoogleAuthButtonContainer(),

            ],),
          ),
        ],
      ),
    )
    );
  }
}
