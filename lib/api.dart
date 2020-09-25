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
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&pageSize=100&apiKey=3d0174f321ba406daf5daa0f48d5c724";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((item) {
        if (item['urlToImage'] != null &&
            item['description'] != null &&
            item['source']['name'] != null &&
            item['publishedAt'] != null) {
          var shortTitle = item['title'].split(' - ');
          var date = item['publishedAt'].split('T');
          var splitDate = date[0].split('-');
          var mainNewsModel = MainNewsModel(
              title: shortTitle[0],
              description: item['description'],
              url: item['url'],
              urlToImage: item['urlToImage'],
              author: item['source']['name'],
              dateTime: splitDate[2] +'/'+ splitDate[1] + '/' + splitDate[0]);
          mainnewslist.add(mainNewsModel);
        }
      });
    }
  }
}
