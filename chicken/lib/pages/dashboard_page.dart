import 'package:flutter/material.dart';
import 'package:chicken/pages/home_page.dart';


class DashboardPage extends StatefulWidget {
  final String argument;
  const DashboardPage({Key key, @required this.argument}) : super(key: key);
  @override
  DashboardPageState createState() => new DashboardPageState(argument);
}

class DashboardPageState extends State<DashboardPage>{
  String argument;
  DashboardPageState(this.argument);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Dashboard"),
        elevation: .1,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                child: SingleChildScrollView( child:  ConstrainedBox(
    constraints: BoxConstraints(), child:Column(
                  children: [
                    new Container(
                      child: Text('Welcome to Prime Message',
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                      child: GridView.count(
                       childAspectRatio:MediaQuery.of(context).size.height / 300,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        primary: false,
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(3.0),
                        children: <Widget>[
                          makeDashboardItem("Scan People", Icons.scanner)
                        ],
                      ),
                    ),
                  ]
                    )
                )
                )
                )
              );
  }
  Card makeDashboardItem(String title, IconData icon) {

    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child:  Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              print(argument);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                    child: Icon(
                      icon,
                      size: 20.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 10.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 10.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}

