import "package:flutter/material.dart";
import "package:flutter_application_stage_project/screens/family/dataScreen.dart";
import "package:flutter_application_stage_project/screens/family/kanban.dart";

class popupMenuButtonKanban extends StatelessWidget {
  const popupMenuButtonKanban({
    super.key,
    required this.themeData,
    required this.widget,
  });

  final ThemeData themeData;
  final KanbanScreen widget;

  @override
  Widget build(BuildContext context) {
    int idBotton = 1;

    if (widget.idFamily == '6') {
      idBotton = 1;
    } else if (widget.idFamily == '3') {
      idBotton = 2;
    } else if (widget.idFamily == '7') {
      idBotton = 3;
    }
    return PopupMenuButton<int>(
      icon:
          Icon(Icons.more_vert, color: themeData.appBarTheme.iconTheme!.color),
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
                  style:
                      TextStyle(color: themeData.textTheme.bodyText1!.color)),
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
                  style:
                      TextStyle(color: themeData.textTheme.bodyText1!.color)),
            ],
          ),
        ),
      ],
    );
  }
}
