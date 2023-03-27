import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/model/city.dart';
import '../modules/home/controllers/home_controller.dart';
import '../utils/dotenv.dart';

class CityWidget extends GetView<HomeController> {
  const CityWidget({
    Key? key,
    required this.provinceId,
    required this.type,
  }) : super(key: key);

  final int provinceId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<CityModel>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
          labelText: type == "from" ? "Kota Asal" : "Kota Tujuan",
          hintText: "Kota Asal Pengiriman",
        )),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
            "https://api.rajaongkir.com/starter/city?province=$provinceId",
          );
          try {
            final response = await http.get(
              url,
              headers: {
                "key": DotEnvUtil.backendApi,
              },
            );
            var data = json.decode(response.body) as Map<String, dynamic>;
            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;
            var models = CityModel.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            if (kDebugMode) {
              print(err);
            }
            return List<CityModel>.empty();
          }
        },
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (type == "from") {
              controller.homeTownId.value = int.parse(cityValue.cityId);
            } else {
              controller.destinationCityId.value = int.parse(cityValue.cityId);
            }
          } else {
            if (type == "from") {
              if (kDebugMode) {
                print("Kamu belum memilih kota");
              }
              controller.homeTownId.value = 0;
            } else {
              if (kDebugMode) {
                print("Kamu belum memilih kota");
              }
              controller.destinationCityId.value = 0;
            }
          }
          controller.showButton();
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
