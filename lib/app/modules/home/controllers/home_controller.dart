import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/courier.dart';
import '../../../utils/dotenv.dart';

class HomeController extends GetxController {
  var hiddenHometown = true.obs;
  var homeProvinceId = 0.obs;
  var homeTownId = 0.obs;
  var hiddenDestinationCity = true.obs;
  var destinationProvinceId = 0.obs;
  var destinationCityId = 0.obs;
  var hiddenButton = true.obs;
  var courier = "".obs;

  double itemWeight = 0.0;
  String itemUnit = "gram";

  late TextEditingController weightCalc;

  void costSender() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

    try {
      final response = await http.post(
        url,
        body: {
          "origin": "$homeTownId",
          "destination": "$destinationCityId",
          "weight": "$itemWeight",
          "courier": "$courier",
        },
        headers: {
          "key": DotEnvUtil.backendApi,
          "content-type": "application/x-www-form-urlencoded",
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var result = data['rajaongkir']['results'] as List<dynamic>;

      var listAllCourier = CourierModel.fromJsonList(result);
      var couriers = listAllCourier[0];

      Get.defaultDialog(
        title: couriers.name,
        content: Column(
          children: couriers.costs
              .map((e) => ListTile(
                    title: Text(e.service),
                    subtitle: Text("Rp. ${e.cost[0].value}"),
                    trailing: Text(couriers.code == "post"
                        ? e.cost[0].etd
                        : "${e.cost[0].etd} DAY"),
                  ))
              .toList(),
        ),
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      Get.defaultDialog(
        title: "Problem occur",
        middleText: err.toString(),
      );
    }
  }

  void showButton() {
    if (homeTownId != 0 &&
        destinationCityId != 0 &&
        itemWeight > 0 &&
        courier != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void changeWeight(String value) {
    itemWeight = double.tryParse(value) ?? 0.0;
    String checkUnit = itemUnit;
    switch (checkUnit) {
      case "kg":
        itemWeight = itemWeight * 1000;
        break;
      case "gram":
        itemWeight = itemWeight;
        break;
      default:
        itemWeight = itemWeight;
    }

    if (kDebugMode) {
      print("$itemWeight gram");
    }
    showButton();
  }

  void changeUnit(String value) {
    itemWeight = double.tryParse(weightCalc.text) ?? 0.0;
    switch (value) {
      case "kg":
        itemWeight = itemWeight * 1000;
        break;
      case "gram":
        itemWeight = itemWeight;
        break;
      default:
        itemWeight = itemWeight;
    }

    itemUnit = value;

    if (kDebugMode) {
      print("$itemWeight gram");
    }
    showButton();
  }

  @override
  void onInit() {
    weightCalc = TextEditingController(text: "$itemWeight");
    super.onInit();
  }

  @override
  void onClose() {
    weightCalc.dispose();
    super.onClose();
  }
}
