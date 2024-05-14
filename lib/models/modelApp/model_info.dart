class Module {
  final bool success;
  final DealInfoModel data;

  Module({
    required this.success,
    required this.data,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      success: json['success'],
      data: DealInfoModel.fromJson(json['data']),
    );
  }
}

class DealInfoModel {
  final String elementId;
  final String owner;
  final String label;
  final String stagePipeline;
  final String organisation;
  final String source;
  final String status;
  final String reference;
  final String contactType;
  final String creationSource;
  final String uuid;
  final String email;
  final String role;
  final String extension;
  final String pipeline;
  final String paysOuLeCentreDappelsEstBasePhysique;
  final List<String> partagerAvec;

  DealInfoModel({
    required this.contactType,
    required this.creationSource,
    required this.uuid,
    required this.email,
    required this.role,
    required this.extension,
    required this.pipeline,
    required this.paysOuLeCentreDappelsEstBasePhysique,
    required this.partagerAvec,
    required this.elementId,
    required this.owner,
    required this.label,
    required this.stagePipeline,
    required this.organisation,
    required this.source,
    required this.status,
    required this.reference,
  });

  factory DealInfoModel.fromJson(Map<String, dynamic> json) {
    return DealInfoModel(
      elementId: json['id'] ?? '',
      owner: json['owner'] ?? '',
      label: json['label'] ?? '',
      stagePipeline: json['stage_pipeline'] ?? '',
      organisation: json['organisation'] ?? '',
      source: json['source'] ?? '',
      status: json['status'] ?? '',
      reference: json['reference'] ?? '',
      partagerAvec: List<String>.from(json['partager_avec'] ?? []),
      contactType: json['contactType'] ?? '',
      creationSource: json['creationSource'] ?? '',
      uuid: json['uuid'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      extension: json['extension'] ?? '',
      pipeline: json['pipeline'] ?? '',
      paysOuLeCentreDappelsEstBasePhysique:
          json['paysOuLeCentreDappelsEstBasePhysique'] ?? '',
    );
  }
}
