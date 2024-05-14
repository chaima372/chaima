import 'package:flutter/material.dart';
import 'package:flutter_application_stage_project/core/constants/FieldWidgetGenerator.dart';
import 'package:flutter_application_stage_project/models/fields/datafieldgroup.dart';
import 'package:flutter_application_stage_project/models/fields/datafieldgroupresponse.dart';
import 'package:flutter_application_stage_project/models/fields/datafieldsresponse.dart';
import 'package:flutter_application_stage_project/models/fields/fileData.dart';
import 'package:flutter_application_stage_project/services/gestion/ApiField.dart';
import 'package:flutter_application_stage_project/services/gestion/ApiFieldGroup.dart';
import 'package:flutter_application_stage_project/services/gestion/ApiFieldPost.dart';

class AddTicket extends StatefulWidget {
  final String family_id;
  final String titel;

  const AddTicket({required this.family_id, required this.titel, Key? key})
      : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  List<DataFields> data = [];
  Map<String, List<DataFieldGroup>> dataGroupMap = {};
  final TextEditingController emailController = TextEditingController();
  Map<String, dynamic> fieldValues = {};
  Map<String, bool> fieldDataFetchedMap = {};
  List<String> fetchedGroupIds = [];

  @override
  void initState() {
    super.initState();
    fetchData(widget.family_id);
  }

  Future<void> fetchData(String id) async {
    try {
      DataFieldRespone fetchedData = await ApiFieldGroup.getGroupfields(id);
      setState(() {
        data = fetchedData.data
            .map((field) => DataFields(
                  id: field.id,
                  label: field.label,
                  isExpanded: false,
                ))
            .toList();
      });
    } catch (e) {
      print('Erreur lors de la récupération des données : $e');
    }
  }

  Future<void> fetchFeildData(String groupId) async {
    if (fetchedGroupIds.contains(groupId)) {
      // Si les données pour ce groupe ont déjà été récupérées, ne lancez pas d'appel API redondant
      return;
    }

    try {
      DataFieldGroupResponse fetchDataGroup =
          await ApiField.getFeildsData(groupId);

      setState(() {
        dataGroupMap[groupId] = fetchDataGroup.data;
        fetchedGroupIds
            .add(groupId); // Ajoutez l'ID du groupe aux groupes récupérés
      });
    } catch (e) {
      print('Failed to fetch  : $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter un ${widget.titel}")),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  final groupId = data[panelIndex].id.toString();
                  if (!isExpanded && !dataGroupMap.containsKey(groupId)) {
                    fetchFeildData(groupId);
                  }
                  setState(() {
                    data[panelIndex].isExpanded = !isExpanded;
                  });
                },
                children: data.map<ExpansionPanel>((DataFields item) {
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(item.label),
                        onTap: () {},
                      );
                    },
                    body: dataGroupMap[item.id.toString()]?.isEmpty ?? true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: dataGroupMap[item.id.toString()]!
                                .map((groupfield) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: FieldWidgetGenerator(
                                  dataFieldGroup: groupfield,
                                  emailController: emailController,
                                  formMap: fieldValues,
                                ),
                              );
                            }).toList(),
                          ),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(fieldValues.toString());
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final fielPostResponse = await ApiFieldPost.fieldPost(
                          fieldValues, int.parse(widget.family_id));
                      print("Response: $fielPostResponse");

                      if (fielPostResponse == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            action:
                                SnackBarAction(label: "Ok", onPressed: () {}),
                            content: Text('Formulaire soumis avec succès !'),
                          ),
                        );
                      }
                    } catch (e) {
                      print("Error $e");
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.purple[200],
                        action: SnackBarAction(label: "Ok", onPressed: () {}),
                        content: Text(
                            'Vérifiez les validations de vos champs requis'),
                      ),
                    );
                  }
                },
                child: Text("Enregistrer"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
