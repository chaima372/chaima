import 'package:flutter/material.dart';

class DataModelKanban {
  List<Stage> stagesD;

  DataModelKanban({required this.stagesD});

  factory DataModelKanban.fromJson(Map<String, dynamic> json) {
    List<dynamic> stageList = json['data'];
    List<Stage> stages =
        stageList.map((stageJson) => Stage.fromJson(stageJson)).toList();
    return DataModelKanban(stagesD: stages);
  }
}

class Stage {
  final int stageId;
  final String stageName;
  Color? stageColor;
  final double? stagePercent;
  final int total;
  final int lastPage;
  final List<Element> elements;

  Stage({
    required this.stageId,
    required this.stageName,
    this.stageColor,
    this.stagePercent,
    required this.total,
    required this.lastPage,
    required this.elements,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    List<dynamic> elementList = json['elements'];
    List<Element> elements = elementList
        .map((elementJson) => Element.fromJson(elementJson))
        .toList();

    // Convertir la couleur de la chaîne hexadécimale en objet Color
    Color color = Color(int.parse(json['stage_color'].replaceAll('#', '0xFF')));

    return Stage(
      stageId: json['stage_id'],
      stageName: json['stage_name'],
      stageColor: color,
      stagePercent: json['stage_percent'] != null
          ? json['stage_percent'].toDouble()
          : null,
      total: json['total'],
      lastPage: json['last_page'],
      elements: elements,
    );
  }
}

class Element {
  final String elementId;
  final int familyId;
  final String? status;
  final int stageId;
  final int requiredFields;
  final int canCreateRoom;
  final ElementInfo elementInfo;

  Element({
    required this.elementId,
    required this.familyId,
    this.status,
    required this.stageId,
    required this.requiredFields,
    required this.canCreateRoom,
    required this.elementInfo,
  });

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
      elementId: json['element_id'],
      familyId: json['family_id'],
      status: json['status'],
      stageId: json['stage_id'],
      requiredFields: json['required_fields'],
      canCreateRoom: json['can_create_room'],
      elementInfo: ElementInfo.fromJson(json['element_info']),
    );
  }
}

class ElementInfo {
  final String labelData;
  final Creator creator;
  final List<Info> info;

  ElementInfo({
    required this.labelData,
    required this.creator,
    required this.info,
  });

  factory ElementInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> infoList = json['info'];
    List<Info> infos =
        infoList.map((infoJson) => Info.fromJson(infoJson)).toList();

    return ElementInfo(
      labelData: json['label_data'],
      creator: Creator.fromJson(json['creator']),
      info: infos,
    );
  }
}

class Creator {
  final String id;
  final String label;
  final String avatar;

  Creator({
    required this.id,
    required this.label,
    required this.avatar,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      label: json['label'],
      avatar: json['avatar'] ?? '', // Avatar peut être null
    );
  }
}

class Info {
  final String projectName;
  final String dealName;
  final String account;
  final String channelSource;
  final String? reference;
  final String? accountManager;
  final String code;
  final String chargeCommercial;
  final String customers;
  final String ticketType;
  final String channel;
  final String subject;
  final String severity;

  Info({
    required this.projectName,
    required this.dealName,
    required this.account,
    required this.channelSource,
    required this.code,
    required this.chargeCommercial,
    required this.customers,
    required this.ticketType,
    required this.channel,
    required this.subject,
    required this.severity,
    this.reference,
    this.accountManager,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      projectName: json['Project Name'] ?? '',
      dealName: json['Deal name'] ?? '',
      account: json['Account'] ?? '',
      channelSource: json['Channel Source'] ?? '',
      reference: json['Référence'],
      accountManager: json['Account Manager'],
      code: json['Code'] ?? '',
      chargeCommercial: json['Charge Commercial'] ?? '',
      customers: json['Customers'] ?? '',
      ticketType: json['Ticket Type'] ?? '',
      channel: json['Channel'] ?? '',
      subject: json['Subject'] ?? '',
      severity: json['Severity'] ?? '',
    );
  }
}
