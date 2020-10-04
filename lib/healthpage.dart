import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:new_app/webview.dart';
import 'package:new_app/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_app/covidpage.dart';
import 'package:share/share.dart';

class Healthpage extends StatefulWidget {
  @override
  _HealthpageState createState() => _HealthpageState();
}

class _HealthpageState extends State<Healthpage> {
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
        title: Text("Health News",
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
                    author: mainnews[index].author,
                    dateTime: mainnews[index].dateTime,
                  );
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
  final String title, desc, url, imageUrl, author, dateTime;
  MainNewsCard(
      {this.desc,
      this.imageUrl,
      this.title,
      this.url,
      this.author,
      this.dateTime});

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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Webview(url: url)));
                      //launch(url);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(imageUrl: imageUrl)),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Webview(url: url)));
                      //launch(url);
                    },
                    child: Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Webview(url: url)));
                      //launch(url);
                    },
                    child: Text(desc,
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(author,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green)),
                      ),
                      Text(dateTime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green)),
                      IconButton(
                        iconSize: 22,
                        color: Colors.green,
                        icon: Icon(FontAwesomeIcons.globe),
                        onPressed: () {
                          launch(url);
                        },
                      ),
                      IconButton(
                        iconSize: 22,
                        color: Colors.green,
                        icon: Icon(FontAwesomeIcons.shareAlt),
                        onPressed: () {
                          Share.share(title +
                              '\n' +
                              url +
                              '\nSource: ' +
                              author +
                              ' via Stay Updated\n\n' +
                              'Download now:\n' +
                              'https://play.google.com/store/apps/details?id=com.news.stayUpdated');
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
  String dateTime;

  MainNewsModel(
      {this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.author,
      this.dateTime});
}

class MainNews {
  List mainnewslist = [];

  Future<void> mainNews() async {
    String url = "http://shauryasuman.pythonanywhere.com/health";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    jsonData.forEach((item) {
      if (item['urlToImage'] != null &&
          item['description'] != null &&
          item['author'] != null &&
          item['publishedAt'] != null) {
        var shortTitle = item['title'].split(' - ');
        var date = item['publishedAt'].split('T');
        var splitDate = date[0].split('-');
        var mainNewsModel = MainNewsModel(
            title: shortTitle[0],
            description: item['description'],
            url: item['url'],
            urlToImage: item['urlToImage'],
            author: item['author'],
            dateTime: splitDate[2] + '/' + splitDate[1] + '/' + splitDate[0]);
        mainnewslist.add(mainNewsModel);
      }
    });
  }
}