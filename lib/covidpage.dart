import 'dart:convert';
import 'package:NEW_APP/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:NEW_APP/moreinfo.dart';




class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {

  Map indiaStats;
  Map worldStats;
  List allCountryList;

  Future getData() async {
    String all_country_url = 'https://corona.lmao.ninja/v2/countries';
    String india_url = 'https://corona.lmao.ninja/v2/countries/india';
    String world_url = 'https://corona.lmao.ninja/v2/all';

    http.Response all_country_response = await http.get(all_country_url);
    http.Response world_response = await http.get(world_url);
    http.Response india_response = await http.get(india_url);
    setState(() {

      allCountryList = jsonDecode(all_country_response.body);
      worldStats = jsonDecode(world_response.body);
      indiaStats = jsonDecode(india_response.body);

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        showSearch(context: context, delegate: Search(allCountryList));
      },
          icon: Icon(FontAwesomeIcons.search),
          label: Text("SEARCH",  style: TextStyle(fontWeight: FontWeight.bold),),
        
      backgroundColor: Colors.green,
      //shape: RoundedRectangleBorder(),
    ),
      appBar: AppBar(
        title: Text("COVID - 19 TRACKER",style: TextStyle(fontFamily: 'ChelseaMarket'),),
      ),
      body: indiaStats==null ? Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 20,
                child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(20),
                color: Colors.orange[300],
                child: Text("Human kindness has never weakened the stamina or softened the fibre of free people. A nation does not have to be cruel to be tough.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      ),
                      ),
              ),
            ),
            SizedBox(height: 10,),
            Text("- - - INDIA - - -", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'ChelseaMarket'),),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StatusPanel(
                    title: "CONFIRMED",
                    panelColor: Colors.red[200],
                    textColor: Colors.red[800],
                    count: indiaStats['cases'].toString(),
                  ),
                  StatusPanel(
                    title: "ACTIVE",
                    panelColor: Colors.blue[200],
                    textColor: Colors.blue[800],
                    count: indiaStats['active'].toString(),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StatusPanel(
                    title: "RECOVERED",
                    panelColor: Colors.green[200],
                    textColor: Colors.green[800],
                    count: indiaStats['recovered'].toString(),
                  ),
                  StatusPanel(
                    title: "DEATHS",
                    panelColor: Colors.blueGrey[100],
                    textColor: Colors.blueGrey[700],
                    count: indiaStats['deaths'].toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text("- - - WORLD - - -", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'ChelseaMarket'),),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StatusPanel(
                    title: "CONFIRMED",
                    panelColor: Colors.red[200],
                    textColor: Colors.red[800],
                    count: worldStats['cases'].toString(),
                  ),
                  StatusPanel(
                    title: "ACTIVE",
                    panelColor: Colors.blue[200],
                    textColor: Colors.blue[800],
                    count: worldStats['active'].toString(),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  StatusPanel(
                    title: "RECOVERED",
                    panelColor: Colors.green[200],
                    textColor: Colors.green[800],
                    count: worldStats['recovered'].toString(),
                  ),
                  StatusPanel(
                    title: "DEATHS",
                    panelColor: Colors.blueGrey[100],
                    textColor: Colors.blueGrey[700],
                    count: worldStats['deaths'].toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            MoreInfo(),
            SizedBox(height: 40),
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(5),
              child: Stack(alignment: Alignment.center,
                children: <Widget>[
                  Image(
                    fit: BoxFit.fill,
                    height: 150,
                    width: 300,
                    image: AssetImage('assets/indiaflag.jpg')),
                  Text("WE ARE TOGETHER",
                  style: TextStyle(fontSize: 30,
                   fontFamily: 'ChelseaMaket', 
                   fontWeight: FontWeight.bold, 
                   color: Colors.purple[700]),
                   ),
                ], 
              ),
            ), 
            SizedBox(height: 70),
        ],
        ),
      ),
    );
  }
}


class StatusPanel extends StatelessWidget {

    final Color panelColor;
    final Color textColor;
    final String title;
    final String count;

    StatusPanel({this.count, this.panelColor, this.textColor, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(0.1),
      child: Card(
        elevation: 10,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            ),
        child: Container(
          color: panelColor,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width/2.4,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),),
              Text(count, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}