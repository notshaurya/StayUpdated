import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Search extends SearchDelegate{

  final List conutryList;
  Search(this.conutryList);

  @override
  String get searchFieldLabel => 'Type country name here';

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: () {
          query='';
        },)
      ];
    }
  
  @override
  Widget buildLeading(BuildContext context) {
      return IconButton(icon: Icon(Icons.arrow_back), onPressed:(){
        Navigator.pop(context);
      } 
      );
    }

  @override
  Widget buildResults(BuildContext context) {
      return Container();
    }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty? conutryList
    : conutryList.where((element) => element['country'].toString().startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 100,
       child: Container(
         
         height: 150,
         margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
         child: Row(
           children: <Widget>[
             Container(
               padding: EdgeInsets.only(left:10),
               width: 200,
               margin: EdgeInsets.symmetric(horizontal: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text(
                     suggestionList[index]['country'],
                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                   ),
                   CachedNetworkImage(
                    imageUrl: suggestionList[index]['countryInfo']['flag'],
                     height: 80,
                     width: 100,
                   ),
                 ],
               ),
             ),
             Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   Text(
                     'CONFIRMED:' +
                         suggestionList[index]['cases'].toString(),
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Colors.red,
                         fontSize: 15),
                   ),
                   Text(
                     'ACTIVE:' +
                         suggestionList[index]['active'].toString(),
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Colors.blue,
                         fontSize: 15),
                   ),
                   Text(
                     'RECOVERED:' +
                         suggestionList[index]['recovered'].toString(),
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Colors.green,
                         fontSize: 15),
                   ),
                   Text(
                     'DEATHS:' +
                         suggestionList[index]['deaths'].toString(),
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color:  Colors.black,
                         fontSize: 15),
                   ),
                 ],
               ),
             )
           ],
         ),
       ),
     );
    },
    );
  }
 
}