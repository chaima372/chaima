class DataModelTable {
  final String id;
  final String owner;
  final String ownerAvatar;
  final int stageId;
  final String label;
  final String stagePipeline;
  final String organisation;
  final String reference;
  final String status;
  final String associe;
  final String listOfCustomers;
  final String contact;
  final String perimeters;
  final String pipeline;
  final String typeTicket;
  final String channel;
  final String subject;
  final String sal;
  final String severity;

  DataModelTable({
    required this.id,
    required this.owner,
    required this.ownerAvatar,
    required this.stageId,
    required this.label,
    required this.stagePipeline,
    required this.organisation,
    required this.reference,
    required this.status,
    required this.associe,
    required this.listOfCustomers,
    required this.contact,
    required this.perimeters,
    required this.pipeline,
    required this.typeTicket,
    required this.channel,
    required this.subject,
    required this.sal,
    required this.severity,
  });

  factory DataModelTable.fromJson(Map<String, dynamic> json) {
    return DataModelTable(
      id: json['id'] ?? '',
      owner: json['owner'] ?? '',
      ownerAvatar: json['owner_avatar'] ?? '',
      stageId: json['stage_id'] ?? 0,
      label: json['label'] ?? '',
      stagePipeline: json['stage_pipeline'] ?? '',
      organisation: json['organisation'] ?? '',
      reference: json['reference'] ?? '',
      status: json['status'] ?? '',
      associe: json['associe'] ?? '',
      listOfCustomers: json['list_of_customers'] ?? '',
      contact: json['contact'] ?? '',
      perimeters: json['perimeters'] ?? '',
      pipeline: json['pipeline'] ?? '',
      typeTicket: json['type_ticket'] ?? '',
      channel: json['channel'] ?? '',
      subject: json['subject'] ?? '',
      sal: json['sal'] ?? '',
      severity: json['severity'] ?? '',
    );
  }
}
