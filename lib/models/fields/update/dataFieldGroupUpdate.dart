import '../FieldListView..dart';

class DataFieldGroupUpdate {
  final int id;
  final String alias;
  final bool hidden;
  final bool required;
  final bool uniqueValue;
  final String field_type;
  final String placeholder;
  final int reference;
  final int multiple;
  final int module;
  final String value_id;
  final String value;
  List<FieldListView> listfieldsview;
  List value_array;
  List value_id_array;
  DataFieldGroupUpdate({
    required this.id,
    required this.alias,
    required this.hidden,
    required this.required,
    required this.uniqueValue,
    required this.field_type,
    required this.placeholder,
    required this.reference,
    required this.multiple,
    required this.module,
    required this.listfieldsview,
    required this.value,
    required this.value_id,
    required this.value_array,
    required this.value_id_array,
  });
  factory DataFieldGroupUpdate.fromJson(Map<String, dynamic> json) {
    return DataFieldGroupUpdate(
      id: json["id"],
      alias: json["alias"],
      hidden: json["hidden"] ??
          false, // Si la valeur est null, utilisez false par défaut
      required: json["required"] ??
          false, // Si la valeur est null, utilisez false par défaut
      uniqueValue: json["uniqueValue"] ??
          false, // Si la valeur est null, utilisez false par défaut
      field_type: json["field_type"],
      placeholder: json["placeholder"] ?? "",
      reference: json["reference"],
      multiple: json["multiple"],
      module: json["module"] ?? 0,
      listfieldsview: (json["field_list_value"] as List)
              .map((list) => FieldListView.formJson(list))
              .toList() ??
          [],
      value: json["value"] ?? "",
      value_id: "${json["value_id"]}" ?? "",
      value_array: json["value_array"] ?? [],
      value_id_array: (json["value_id_array"] ?? []).map((value) {
        if (value is String) {
          return value;
        } else if (value is int) {
          return value.toString(); // Convert int to String
        } else {
          // Handle unexpected types (optional)
          print("Warning: Unexpected type in value_id_array: $value");
          return ""; // Or throw an exception if needed
        }
      }).toList(),
    );
  }
}
