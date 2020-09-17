import 'dart:async';
import 'package:new_app/webview.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_app/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_app/covidpage.dart';
import 'package:share/share.dart';

class Businesspage extends StatefulWidget {
  @override
  _BusinesspageState createState() => _BusinesspageState();
}

class _BusinesspageState extends State<Businesspage> {
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
      drawer: Drawer(
        child: SideDrawer(),
      ),
      appBar: AppBar(
        title: Text("Business News",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'ChelseaMarket',
                fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mainnews.length,
                itemBuilder: (context, index) {
                  return MainNewsCard(
                      title: mainnews[index].title,
                      desc: mainnews[index].description,
                      url: mainnews[index].url,
                      imageUrl: mainnews[index].urlToImage,
                      author: mainnews[index].author);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CovidPage(),
            ),
          );
        },
        icon: Icon(FontAwesomeIcons.procedures),
        label: Text(
          "COVID STATS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class MainNewsCard extends StatelessWidget {
  final String title, desc, url, imageUrl, author;
  MainNewsCard({this.desc, this.imageUrl, this.title, this.url, this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Webview(url: url)));
        //launch(url);
      },
      child: Center(
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(7),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(imageUrl: imageUrl)),
                  SizedBox(height: 10),
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(desc,
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.shareAlt),
                        onPressed: () {
                          Share.share(title);
                        },
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

// API for current category..

class MainNewsModel {
  String title;
  String description;
  String url;
  String urlToImage;
  String author;

  MainNewsModel(
      {this.title, this.description, this.url, this.urlToImage, this.author});
}

class MainNews {
  List mainnewslist = [];

  Future<void> mainNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=3d0174f321ba406daf5daa0f48d5c724";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((item) {
        if (item['urlToImage'] != null && item['description'] != null) {
          var mainNewsModel = MainNewsModel(
              title: item['title'],
              description: item['description'],
              url: item['url'],
              urlToImage: item['urlToImage'],
              author: item['author']);

          mainnewslist.add(mainNewsModel);
        }
      });
    }
  }
}
