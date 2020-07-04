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
//     Raised button is a widget that gives some
//     automatic Material design styles
      return OutlineButton(
     splashColor: Colors.grey,
     onPressed: onPressedCallback,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
     highlightElevation: 0,
     borderSide: BorderSide(color: Colors.grey),
     child: Padding(
       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
       child: Row(
         mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text(
               buttonText,
               style: TextStyle(
                 fontSize: 20,
                 color: Colors.grey,
               ),
             ),
           )
         ],
       ),
     ),
   );
 }
  
}