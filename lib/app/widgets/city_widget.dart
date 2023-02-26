import 'dart:convert';

import 'package:cekongkir/app/data/model/city_model.dart';
import 'package:cekongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

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
          labelText:
              type == "from" ? "Home City/Regency" : "Destination City/Regency",
          hintText: "City/Regency in your province",
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
                "key": dotenv.get('BACKEND_API_KEY'),
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
              print("You are not choose any city/regency");
              controller.homeTownId.value = 0;
            } else {
              print("You are not choose any city/regency");
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
