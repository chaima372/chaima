import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/components/app/shimnerDataScreen.dart';
import 'package:flutter_application_stage_project/core/constants/design/theme.dart';
import 'package:flutter_application_stage_project/models/modelApp/model_info.dart';

import 'package:flutter_application_stage_project/providers/theme_provider.dart';
import 'package:flutter_application_stage_project/services/servicesApp/server_info.dart';
import 'package:provider/provider.dart';

class DealInfoPage extends StatefulWidget {
  final String elementId;
  final String ownerAvatar; // Ajout du paramètre ownerAvatar

  const DealInfoPage(
      {Key? key, required this.elementId, required this.ownerAvatar})
      : super(key: key);

  @override
  _DealInfoPageState createState() => _DealInfoPageState();
}

class _DealInfoPageState extends State<DealInfoPage> {
  late Future<Module> _futureModule;
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _futureModule = _fetchModule();
  }

  Future<Module> _fetchModule() async {
    try {
      return await getDealInfoModel(widget.elementId);
    } catch (error) {
      throw Exception('Failed to fetch module: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData =
        themeProvider.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme;
    return Scaffold(
      body: FutureBuilder<Module>(
          future: _futureModule,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerCard();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final model = snapshot.data!;
              final dealInfo = model.data;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
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
                              "https://spherebackdev.cmk.biz:4543/storage/uploads/${widget.ownerAvatar}",
                            ),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            dealInfo.owner,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: themeData.textTheme.bodyText1!.color,
                            ),
                          ),
                        ]),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (dealInfo.label.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Label: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.label.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.organisation.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Organisation: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.organisation.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.reference.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Reference: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.reference.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.source.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Source: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.source.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.stagePipeline.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Stage Pipeline: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.stagePipeline.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.status.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.status.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.contactType.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Contact Type: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.contactType.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.creationSource.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Creation Source: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.creationSource.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.pipeline.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Pipeline: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.pipeline.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.uuid.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Uuid: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.uuid.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.extension.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Extension: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.extension.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.paysOuLeCentreDappelsEstBasePhysique
                                .trim()
                                .isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Epays Ou Le Centre D '
                                          'appels Est Base Physique: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${dealInfo.paysOuLeCentreDappelsEstBasePhysique.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.role.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Role: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.role.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.email.trim().isNotEmpty)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Email: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${dealInfo.email.trim()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (dealInfo.partagerAvec.isNotEmpty) ...[
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Partager Avec: ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: themeData
                                            .textTheme.bodyText1!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    for (String item in dealInfo.partagerAvec)
                                      TextSpan(
                                        text:
                                            '$item${dealInfo.partagerAvec.last == item ? '' : ', '}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: themeData
                                              .textTheme.bodyText1!.color,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
