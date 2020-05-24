
import 'package:NEW_APP/businesspage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:NEW_APP/homepage.dart';
import 'package:NEW_APP/entertainmentpage.dart';
import 'package:NEW_APP/healthpage.dart';
import 'package:NEW_APP/sportspage.dart';
import 'package:NEW_APP/sciencepage.dart';
import 'package:NEW_APP/technologypage.dart';
import 'package:NEW_APP/homepage.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              'Category News',
              style: TextStyle(
                fontFamily: 'ChelseaMarket',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        SizedBox(height:70),
        ListTile(
          leading: Icon(FontAwesomeIcons.lightbulb, color: Colors.green,),
          title: Text('General', style: TextStyle(
            fontSize: 17,
          ),),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.businessTime, color: Colors.green,),
          title: Text('Business', style: TextStyle(
            fontSize: 17,
          ),),
           onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Businesspage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.video, color: Colors.green,),
          title: Text('Entertainment', style: TextStyle(
            fontSize: 17,
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Entertainmentpage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.clinicMedical, color: Colors.green,),
          title: Text('Health', style: TextStyle(
            fontSize: 17,
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Healthpage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.microscope, color: Colors.green,),
          title: Text('Science', style: TextStyle(
            fontSize: 17,
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Sciencepage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.running, color: Colors.green,),
          title: Text('Sports', style: TextStyle(
            fontSize: 17,
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Sportspage(),
        ),
        );
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.networkWired, color: Colors.green,),
          title: Text('Technology', style: TextStyle(
            fontSize: 17,
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Technologypage(),
        ),
        );
          },
        ),
      ],
    ),
      
    );
  }
}

