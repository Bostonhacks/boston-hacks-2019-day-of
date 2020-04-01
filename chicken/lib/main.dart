import 'package:chicken/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(                             // updated                                  // new
        home: new MyHomePage(),                      // new
    );
  }
}