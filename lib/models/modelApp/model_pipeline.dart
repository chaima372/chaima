class PipelineModel {
  bool success;
  List<DataModel> data;

  PipelineModel({
    required this.success,
    required this.data,
  });

  factory PipelineModel.fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      success: json['success'],
      data:
          List<DataModel>.from(json['data'].map((x) => DataModel.fromJson(x))),
    );
  }
}

class DataModel {
  int id;
  String label;
  List<StageModel> stages;

  DataModel({
    required this.id,
    required this.label,
    required this.stages,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      label: json['label'],
      stages: List<StageModel>.from(
          json['stages'].map((x) => StageModel.fromJson(x))),
    );
  }
}

class StageModel {
  int id;
  String label;
  String color;

  StageModel({
    required this.id,
    required this.label,
    required this.color,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id'],
      label: json['label'],
      color: json['color'],
    );
  }
}
