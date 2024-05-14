import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/components/app/popuMenuButton.dart';
import 'package:flutter_application_stage_project/components/app/shimnerDataScreen.dart';
import 'package:flutter_application_stage_project/core/constants/design/theme.dart';
import 'package:flutter_application_stage_project/models/modelApp/modelTable.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_application_stage_project/screens/bottomNavigationBar.dart';

import 'package:flutter_application_stage_project/screens/family/detail/dealInfoTable.dart';
import 'package:flutter_application_stage_project/screens/family/gestionApp/addTicket.dart';
import 'package:flutter_application_stage_project/services/gestion/ApiDeleteElment.dart';

import 'package:flutter_application_stage_project/services/servicesApp/serverTable.dart';

import 'package:provider/provider.dart';

class DataScreen extends StatefulWidget {
  final String idFamily;
  final int idBotton;
  DataScreen({required this.idFamily, required this.idBotton});

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final DataService _dataService = DataService();
  late Future<List<DataModelTable>> _dataFuture;
  late List<DataModelTable> _dataList;
  List<DataModelTable> _filteredDataList = [];

  late ThemeProvider themeProvider;
  String appBarTitle = '';
  String AjouterTitle = '';
  late int selectedIndex;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataFuture = _dataService.fetchData(widget.idFamily);
    selectedIndex = widget.idBotton;
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    final themeData =
        themeProvider.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme;

    switch (widget.idFamily) {
      case '6':
        appBarTitle = 'Billets';
        break;
      case '7':
        appBarTitle = 'Projects';
        break;
      case '3':
        appBarTitle = 'Affaires';
        break;
      default:
        appBarTitle = 'Data Screen';
        break;
    }

    switch (widget.idFamily) {
      case '6':
        AjouterTitle = 'Billet';
        break;
      case '7':
        AjouterTitle = 'Project';
        break;
      case '3':
        AjouterTitle = 'Affaire';
        break;
      default:
        AjouterTitle = 'Ajoute Screen';
        break;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTicket(
                      family_id: widget.idFamily,
                      titel: AjouterTitle,
                    )),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        //supprimer fleche
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(appBarTitle, style: themeData.appBarTheme.titleTextStyle),
        actions: [
          popuMenuButton(themeData: themeData, widget: widget),
        ],
        backgroundColor: themeData.appBarTheme.backgroundColor,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(index: selectedIndex),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Recherche',
                hintText: 'Entrez le mot-clé de recherche',
                prefixIcon:
                    Icon(Icons.search, color: themeData.iconTheme.color),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _filteredDataList.clear();
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredDataList = _dataList
                      .where((element) => element.owner
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: _buildDataListView(themeData),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView(ThemeData themeData) {
    return FutureBuilder<List<DataModelTable>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerCard();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          _dataList = snapshot.data!;
          if (_filteredDataList.isEmpty) {
            return ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                final item = _dataList[index];
                return _buildDataCard(item, themeData);
              },
            );
          } else {
            return ListView.builder(
              itemCount: _filteredDataList.length,
              itemBuilder: (context, index) {
                final item = _filteredDataList[index];
                return _buildDataCard(item, themeData);
              },
            );
          }
        }
      },
    );
  }

  Widget _buildDataCard(DataModelTable item, ThemeData themeData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DealInfoPageTable(
                    elementId: item.id,
                    ownerAvatar: item.ownerAvatar,
                    label: item.owner)));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: themeData.cardTheme.color,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://spherebackdev.cmk.biz:4543/storage/uploads/${item.ownerAvatar}",
                  ),
                  radius: 25,
                ),
                SizedBox(width: 5),
                Text(
                  widget.idFamily == '6' ? item.owner : item.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: themeData.textTheme.bodyText1!.color,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.owner.trim().isNotEmpty)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Owner: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: themeData.textTheme.bodyText1!.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '${item.owner.trim()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: themeData.textTheme.bodyText1!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Add other conditions for displaying data fields
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
