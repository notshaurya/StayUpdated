import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:NEW_APP/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:NEW_APP/covidpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List mainnews = List();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    var news = MainNews();
    await news.mainNews();
    mainnews = news.mainnewslist;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text("Stay",style: TextStyle(fontSize: 20, fontFamily: 'ChelseaMarket',fontWeight: FontWeight.bold)),
          Text("Updated",style: TextStyle(fontSize: 25,fontFamily: 'ChelseaMarket', color: Colors.lightGreenAccent, fontWeight: FontWeight.bold))
        ],
        ),
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator()
        ) 
        : GestureDetector(
          onTap: (){
            
          },
            child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mainnews.length,
              itemBuilder: (context, index){
                return MainNewsCard(
                  title: mainnews[index].title,
                  desc: mainnews[index].description,
                  url: mainnews[index].url,
                  imageUrl: mainnews[index].urlToImage,
                  author: mainnews[index].author
              );
            }, 
      ),
      ),
        ),
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CovidPage(),
        ),
        );
      },
          icon: Icon(FontAwesomeIcons.procedures),
          label: Text("COVID STATS",  style: TextStyle(fontWeight: FontWeight.bold),),
        
      backgroundColor: Colors.green,
      //shape: RoundedRectangleBorder(),
    ),
    );
  }
}


class MainNewsCard extends StatelessWidget {

  final String title, desc, url, imageUrl, author;
  MainNewsCard({this.desc, this.imageUrl, this.title, this.url, this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      launch(url);
    },
          child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: 
                  CachedNetworkImage(imageUrl: imageUrl)),
                SizedBox(height: 15),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                SizedBox(height: 10),
                Text(desc, style: TextStyle(fontSize: 17, color: Colors.black))
              ]
            ),
          ),
        ),
      ),
    );
  }
}