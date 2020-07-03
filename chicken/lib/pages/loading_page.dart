import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
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
                colors: [
                  const Color(0xFFFAFAFA),
                  const Color(0xFFFAFAFA),
                ],
              ),
            ),
            child: new Text(
              'Loading',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ],
      ),
    );
  }
}