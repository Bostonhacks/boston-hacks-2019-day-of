import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingPage extends StatelessWidget {
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
            HeartbeatProgressIndicator(
              child: Image(image: AssetImage("assets/Feliz.png"), height: 100.0),
            ),
            SizedBox(height: 16.0),
            Text(
                  'Loading',
                  style: Theme.of(context).textTheme.headline,
                  ),

            ],),
          ),
        ],
      ),
    )
    );
  }
}
