import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/components/app/shimnerDataScreen.dart';
import 'package:flutter_application_stage_project/core/constants/design/theme.dart';
import 'package:flutter_application_stage_project/models/modelApp/model_kanban.dart';
import 'package:flutter_application_stage_project/models/modelApp/model_pipeline.dart';
import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_application_stage_project/screens/bottomNavigationBar.dart';
import 'package:flutter_application_stage_project/screens/family/dataScreen.dart';
import 'package:flutter_application_stage_project/screens/family/detailTableKanban.dart';
import 'package:flutter_application_stage_project/screens/family/gestionApp/addTicket.dart';

import 'package:flutter_application_stage_project/services/servicesApp/serverKanban.dart';
import 'package:flutter_application_stage_project/services/servicesApp/server_Pipeline.dart';
import 'package:provider/provider.dart';

class KanbanScreen extends StatefulWidget {
  final String idFamily;
  final int idBotton;
  KanbanScreen({required this.idFamily, required this.idBotton});

  @override
  _KanbanScreenState createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  DataModelKanban? _dataModel;
  List<DataModel> pipelines = [];
  DataModel? selectedPipeline;
  Stage? selectedStage;
  late ThemeProvider themeProvider;
  String appBarTitle = '';
  String AjouterTitle = '';
  String _selectedRadio = '';
  late int selectedIndex;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    selectedIndex = widget.idBotton;
    fetchPipelines();
  }

  Future<void> fetchData(int idPipeline) async {
    try {
      final data = await getDataModelKanban(idPipeline);
      setState(() {
        _dataModel = data;
        if (_dataModel!.stagesD.isNotEmpty) {
          selectedStage = _dataModel!.stagesD.first;
        }
        _isLoading = false; // Update loading state when data is loaded
      });
    } catch (error) {
      log('Error fetching data: $error');
    }
  }

  Future<void> fetchPipelines() async {
    try {
      final pipelineModel = await getPipeline(widget.idFamily);
      setState(() {
        pipelines = pipelineModel.data;
      });
      if (pipelines.isNotEmpty) {
        selectedPipeline = pipelines.first;
        fetchData(selectedPipeline!.id);
        _selectedRadio = selectedPipeline!.id.toString();
      }
    } catch (error) {
      log('Error fetching pipelines: $error');
    }
  }

  Future<void> _fetchDataForPipeline(String pipelineId) async {
    try {
      final int idPipeline = int.parse(pipelineId);
      await fetchData(idPipeline);
    } catch (error) {
      log('Error fetching data for pipeline: $error');
    }
  }

  Future<void> _showRadioAlert() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisir un pipeline'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var pipeline in pipelines)
                    ListTile(
                      title: Text(pipeline.label),
                      leading: Radio<String>(
                        value: pipeline.id.toString(),
                        groupValue: _selectedRadio,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRadio = value!;
                          });
                        },
                      ),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _fetchDataForPipeline(_selectedRadio);
                Navigator.pop(context);
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _SearchKanban(String searchText) async {
    if (searchText.isNotEmpty) {
      try {
        final searchData =
            await getSearchkanban(selectedPipeline!.id, searchText);
        setState(() {
          _dataModel = searchData;
        });
      } catch (error) {
        log('Error performing search: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    final themeData =
        themeProvider.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme;

    int idBotton = 1;

    if (widget.idFamily == '6') {
      idBotton = 1;
    } else if (widget.idFamily == '3') {
      idBotton = 2;
    } else if (widget.idFamily == '7') {
      idBotton = 3;
    }

    switch (widget.idFamily) {
      case '6':
        appBarTitle = 'Kanban Billets';
        AjouterTitle = 'Billet';
        break;
      case '7':
        appBarTitle = 'Kanban Projects';
        AjouterTitle = 'Project';
        break;
      case '3':
        appBarTitle = 'Kanban Affaires';
        AjouterTitle = 'Affaire';
        break;
      default:
        appBarTitle = 'Kanban Data Screen';
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
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert,
                color: themeData.appBarTheme.iconTheme!.color),
            onSelected: (int value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataScreen(
                      idFamily: widget.idFamily,
                      idBotton: idBotton,
                    ),
                  ),
                );
              } else if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KanbanScreen(
                      idFamily: widget.idFamily,
                      idBotton: idBotton,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.list, color: themeData.iconTheme.color),
                    SizedBox(width: 8),
                    Text('Table',
                        style: TextStyle(
                            color: themeData.textTheme.bodyText1!.color)),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.view_kanban_outlined,
                        color: themeData.iconTheme.color),
                    SizedBox(width: 8),
                    Text('Kanban',
                        style: TextStyle(
                            color: themeData.textTheme.bodyText1!.color)),
                  ],
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
        title: Text(appBarTitle, style: themeData.appBarTheme.titleTextStyle),
        backgroundColor: themeData.appBarTheme.backgroundColor,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(index: selectedIndex),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: _SearchKanban,
              decoration: InputDecoration(
                labelText: 'Recherche',
                hintText: 'Entrez le mot-clé de recherche',
                prefixIcon:
                    Icon(Icons.search, color: themeData.iconTheme.color),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_vert,
                          color: themeData.iconTheme.color),
                      onPressed: _showRadioAlert,
                    ),
                  ],
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (_isLoading)
            Expanded(
              child: ShimmerCard(),
            ),
          if (!_isLoading && _dataModel != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _dataModel!.stagesD.map((stage) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStage = stage;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: selectedStage == stage
                                    ? Colors.blue
                                    : Colors.grey[200],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: stage.stageName,
                                        style: TextStyle(
                                          color: selectedStage == stage
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: '(${stage.total.toString()})',
                                        style: TextStyle(
                                          color: stage.stageColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (selectedStage != null)
                    Expanded(
                      child: selectedStage!.elements.isEmpty
                          ? Center(
                              child: Text(
                                'Aucun élément à afficher',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: themeData.textTheme.bodyText1!.color,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: selectedStage!.elements.length,
                              itemBuilder: (context, index) {
                                final element = selectedStage!.elements[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          namePipeline: selectedPipeline!.label,
                                          stages: _dataModel!.stagesD,
                                          yourStage: selectedStage!,
                                          stageIds: _dataModel!.stagesD
                                              .map((stage) => stage.stageId)
                                              .toList(),
                                          elementId: element.elementId,
                                          ownerAvatar: element
                                              .elementInfo.creator.avatar,
                                          idFamily: widget.idFamily,
                                          idBotton: widget.idBotton,
                                          label:
                                              element.elementInfo.creator.label,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value == true) {
                                        fetchPipelines();
                                      }
                                    });
                                  },
                                  child: Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: themeData.cardTheme.color,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://spherebackdev.cmk.biz:4543/storage/uploads/${element.elementInfo.creator.avatar}",
                                              ),
                                              radius: 25,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              element.elementInfo.labelData,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: themeData
                                                    .textTheme.bodyText1!.color,
                                              ),
                                            ),
                                          ]),
                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (element
                                                  .elementInfo.creator.label
                                                  .trim()
                                                  .isNotEmpty)
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Label: ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: themeData
                                                              .textTheme
                                                              .bodyText1!
                                                              .color,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${element.elementInfo.creator.label.trim()}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: themeData
                                                              .textTheme
                                                              .bodyText1!
                                                              .color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
