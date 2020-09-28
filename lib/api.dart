import 'dart:convert';
import 'package:http/http.dart' as http;

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
    String url = "http://shauryasuman.pythonanywhere.com/topHeadlines";

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
