import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallback;

  // Passed in from Container
  GoogleAuthButton({
    @required this.buttonText,
    this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    // Raised button is a widget that gives some
    // automatic Material design styles
    return new RaisedButton(
      onPressed: onPressedCallback,
      color: Colors.white,
      child: new Container(
        // Explicitly set height
        // Contianer has many options you can pass it,
        // Most widgets do *not* allow you to explicitly set
        // width and height
        width: 230.0,
        height: 50.0,
        alignment: Alignment.center,
        // Row is a layout widget
        // that lays out its children on a horizontal axis
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding is a convenience widget that adds Padding to it's child
            new Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: new Image.network(
                'https://media-exp1.licdn.com/dms/image/C4D0BAQHiNSL4Or29cg/company-logo_200_200/0?e=1602115200&v=beta&t=1TaEC-RavQkQU43_Tw4UqQ6NSUUK_qlC8kaOCblIxj0',
                width: 30.0,
              ),
            ),
            new Text(
              buttonText,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}