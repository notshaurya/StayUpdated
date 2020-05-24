import 'dart:convert';
import 'package:http/http.dart' as http;

class MainNewsModel {

  String title;
  String description;
  String url;
  String urlToImage;
  String author;

  MainNewsModel({this.title, this.description, this.url, this.urlToImage, this.author});

}

class MainNews {

  List mainnewslist = [];

  Future<void> mainNews() async {

  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=3d0174f321ba406daf5daa0f48d5c724";
  
  var response = await http.get(url);
  
  var jsonData = jsonDecode(response.body);
  
  if (jsonData['status'] == "ok") {
    jsonData['articles'].forEach((item){
      if(item['urlToImage'] != null && item['description'] != null) {
        var mainNewsModel = MainNewsModel(
          title: item['title'],
          description: item['description'],
          url: item['url'],
          urlToImage: item['urlToImage'],
          author: item['author']
        );

        mainnewslist.add(mainNewsModel);

      }
    });
  }
}
}