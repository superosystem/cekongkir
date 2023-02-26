import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    cityId: json["city_id"],
    provinceId: json["province_id"],
    province: json["province"],
    type: json["type"],
    cityName: json["city_name"],
    postalCode: json["postal_code"],
  );

  static List<CityModel> fromJsonList(List list) {
    if (list.isEmpty) return List<CityModel>.empty();

    return list.map((item) => CityModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "province_id": provinceId,
    "province": province,
    "type": type,
    "city_name": cityName,
    "postal_code": postalCode,
  };
}
