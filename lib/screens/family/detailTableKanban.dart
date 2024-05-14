import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/core/constants/design/theme.dart';
import 'package:flutter_application_stage_project/models/modelApp/model_kanban.dart';

import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_application_stage_project/screens/bottomNavigationBar.dart';
import 'package:flutter_application_stage_project/screens/chat_page.dart';

import 'package:flutter_application_stage_project/screens/family/detail/ActivityPage.dart';
import 'package:flutter_application_stage_project/screens/family/detail/commentairePage.dart';
import 'package:flutter_application_stage_project/screens/family/detail/dealInfoPage.dart';
import 'package:flutter_application_stage_project/services/servicesApp/serverKanban.dart';

import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String namePipeline;
  final List<Stage> stages;
  final Stage yourStage;
  final List<int> stageIds;
  final String elementId;
  final String ownerAvatar;
  final String idFamily;
  final int idBotton;
  final String label;

  DetailPage({
    required this.namePipeline,
    required this.stages,
    required this.yourStage,
    required this.stageIds,
    required this.elementId,
    required this.ownerAvatar,
    required this.idFamily,
    required this.idBotton,
    required this.label,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ThemeProvider themeProvider;
  late PageController _pageController;
  late int selectedIndex;
  int _currentIndex = 0;
  String? selectedStageId;
  String _selectedRadio = '';
  String validatedStageName = '';
  List<Widget> stages = [];
  List<String> stageTitles = ["Info générale", "Activités", "commentaire"];
  List<IconData> stageIcons = [Icons.info, Icons.accessibility, Icons.comment];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    selectedStageId = widget.stageIds.first.toString();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    selectedIndex = widget.idBotton;
  }

  Widget _buildStageContent(int index) {
    switch (index) {
      case 0:
        return DealInfoPage(
          elementId: widget.elementId,
          ownerAvatar: widget.ownerAvatar,
        );
      case 1:
        return ActivityPage();
      case 2:
        return ChatPage();
      default:
        return Container();
    }
  }

  Future<void> _showRadioAlert() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sélectionnez une étape'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (Stage stage in widget.stages)
                    ListTile(
                      title: Text(stage.stageName),
                      leading: Radio<String>(
                        value: stage.stageId.toString(),
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
              onPressed: () async {
                setState(() {
                  selectedStageId = _selectedRadio;
                  Stage selectedStage = widget.stages.firstWhere(
                      (stage) => stage.stageId.toString() == selectedStageId);

                  postStage(int.parse(selectedStageId!), widget.elementId,
                      widget.idFamily);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Validation réussie pour ${selectedStage.stageName}'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blue,
                    ),
                  );

                  validatedStageName = selectedStage.stageName;
                });
                Navigator.pop(context);
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: themeData.appBarTheme.iconTheme!.color),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          centerTitle: true,
          title: Text(widget.label),
          actions: [
            IconButton(
              onPressed: _showRadioAlert,
              icon: Icon(Icons.edit,
                  color: themeData.appBarTheme.iconTheme!.color),
            ),
          ]),
      bottomNavigationBar: BottomNavigationBarWidget(index: selectedIndex),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        Text('${widget.namePipeline} :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: themeData.textTheme.bodyText1!.color,
                            )),
                        SizedBox(width: 10),
                        Text(
                          validatedStageName.isNotEmpty
                              ? validatedStageName
                              : widget.yourStage.stageName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: themeData.textTheme.bodyText1!.color,
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          for (int i = 0; i < stageTitles.length; i++)
                            Card(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = i;
                                    _pageController.animateToPage(
                                      _currentIndex,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    children: [
                                      Icon(stageIcons[i],
                                          color: themeData.iconTheme.color),
                                      Text(
                                        stageTitles[i],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildStageContent(0),
                  ActivityPage(),
                  commentairePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
