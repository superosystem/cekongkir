import 'dart:convert';

import 'package:cekongkir/app/data/model/province_model.dart';
import 'package:cekongkir/app/modules/home/controllers/home_controller.dart';
import 'package:cekongkir/app/utils/dotenv_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProvinceWidget extends GetView<HomeController> {
  const ProvinceWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<ProvinceModel>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: type == "from" ? "Provinsi Asal" : "Provinsi Tujuan",
              hintText: "Provinsi di Negara Kamu",
            )),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        asyncItems: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
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

            var listAllProvince = data["rajaongkir"]["results"] as List<dynamic>;
            var models = ProvinceModel.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            if (kDebugMode) {
              print(err);
            }
            return List<ProvinceModel>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (type == "from") {
              controller.hiddenHometown.value = false;
              controller.homeProvinceId.value = int.parse(prov.provinceId);
            } else {
              controller.hiddenDestinationCity.value = false;
              controller.destinationProvinceId.value =
                  int.parse(prov.provinceId);
            }
          } else {
            if (type == "from") {
              controller.hiddenHometown.value = true;
              controller.homeProvinceId.value = 0;
            } else {
              controller.hiddenDestinationCity.value = true;
              controller.destinationProvinceId.value = 0;
            }
          }
          controller.showButton();
        },
        itemAsString: (item) => item.province,
      ),
    );
  }
}