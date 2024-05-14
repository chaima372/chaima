import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> data = ["Apple", "Banana", "Cherry"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.purple,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.purple,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var x in data) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (ctx, index) => ListTile(title: Text(matchQuery[index])));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var x in data) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (ctx, index) => ListTile(title: Text(matchQuery[index])));
  }
}
