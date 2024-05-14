import "package:flutter/material.dart";

class search extends StatelessWidget {
  const search({
    super.key,
    required TextEditingController searchController,
    required this.themeData,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Recherche',
          hintText: 'Entrez le mot-clé de recherche',
          prefixIcon: Icon(Icons.search, color: themeData.iconTheme.color),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
