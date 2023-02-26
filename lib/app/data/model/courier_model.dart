import 'dart:convert';

CourierModel courierModelFromJson(String str) => CourierModel.fromJson(json.decode(str));

String courierModelToJson(CourierModel data) => json.encode(data.toJson());

class CourierModel {
  CourierModel({
    required this.code,
    required this.name,
    required this.costs,
  });

  String code;
  String name;
  List<CourierCostModel> costs;

  factory CourierModel.fromJson(Map<String, dynamic> json) => CourierModel(
    code: json["code"],
    name: json["name"],
    costs: List<CourierCostModel>.from(json["costs"].map((x) => CourierCostModel.fromJson(x))),
  );

  static List<CourierModel> fromJsonList(List list) {
    if (list.isEmpty) return List<CourierModel>.empty();
    return list.map((item) => CourierModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
  };
}

class CourierCostModel {
  CourierCostModel({
    required this.service,
    required this.description,
    required this.cost,
  });

  String service;
  String description;
  List<CostModel> cost;

  factory CourierCostModel.fromJson(Map<String, dynamic> json) => CourierCostModel(
    service: json["service"],
    description: json["description"],
    cost: List<CostModel>.from(json["cost"].map((x) => CostModel.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "service": service,
    "description": description,
    "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
  };
}

class CostModel {
  CostModel({
    required this.value,
    required this.etd,
    required this.note,
  });

  int value;
  String etd;
  String note;

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
    value: json["value"],
    etd: json["etd"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "etd": etd,
    "note": note,
  };
}