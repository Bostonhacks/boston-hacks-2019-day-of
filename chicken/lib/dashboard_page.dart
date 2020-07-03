
import 'package:flutter/material.dart';
import 'package:chicken/login_page.dart';
import 'package:chicken/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:chicken/scan_page.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
             
              Text(
                "Hello, " + name,
                style: GoogleFonts.roboto(textStyle:Theme.of(context).textTheme.display1),
              ),
              SizedBox(height: 20),
              Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: StaggeredGridView.count(
                        shrinkWrap: true,
                        primary: false,
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            makeDashboardItem(context,"Scan people", Icons.scanner, 0xFFFE745F),
            makeDashboardItem(context,"Get Schedule", Icons.schedule, 0xFFF6D374),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 130.0),
            StaggeredTile.extent(1, 150.0)
          ],
        ),
      ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
                color: Color(0xFF4BBC79),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
   Card makeDashboardItem(BuildContext context,String title, IconData icon, int color) {
    return Card(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
     shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24.0),
  ),
      child:
      InkWell ( 
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanPage()),
          ),
            child: IgnorePointer(
        child:Center(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title ,
                  style: GoogleFonts.roboto(color:Color(color), fontSize: 20.0)
                  ),
                  ),
                  ),
                  Material(
                    color:Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 20.0
                      ),
                    )
                  )
                ],
              )
            ],)
        )
      )
      )
      )
      );
  }
}
