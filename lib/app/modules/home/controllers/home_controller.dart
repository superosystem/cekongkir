import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../environment.dart';
import '../../../data/model/courier_model.dart';

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
          "key": Environment.backendApi,
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
        print(err);
      Get.defaultDialog(
        title: "Problem occur",
        middleText: err.toString(),
      );
    }
  }

  void showButton() {
    if (homeTownId != 0 && destinationCityId != 0 && itemWeight > 0 && courier != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void changeWeight(String value) {
    itemWeight = double.tryParse(value) ?? 0.0;
    String checkUnit = itemUnit;
    switch (checkUnit) {
      case "ton":
        itemWeight = itemWeight * 1000000;
        break;
      case "kwintal":
        itemWeight = itemWeight * 100000;
        break;
      case "ons":
        itemWeight = itemWeight * 100;
        break;
      case "lbs":
        itemWeight = itemWeight * 2204.62;
        break;
      case "pound":
        itemWeight = itemWeight * 2204.62;
        break;
      case "kg":
        itemWeight = itemWeight * 1000;
        break;
      case "hg":
        itemWeight = itemWeight * 100;
        break;
      case "dag":
        itemWeight = itemWeight * 10;
        break;
      case "gram":
        itemWeight = itemWeight;
        break;
      case "dg":
        itemWeight = itemWeight / 10;
        break;
      case "cg":
        itemWeight = itemWeight / 100;
        break;
      case "mg":
        itemWeight = itemWeight / 1000;
        break;
      default:
        itemWeight = itemWeight;
    }

    print("$itemWeight gram");
    showButton();
  }

  void changeUnit(String value) {
    itemWeight = double.tryParse(weightCalc.text) ?? 0.0;
    switch (value) {
      case "ton":
        itemWeight = itemWeight * 1000000;
        break;
      case "kwintal":
        itemWeight = itemWeight * 100000;
        break;
      case "ons":
        itemWeight = itemWeight * 100;
        break;
      case "lbs":
        itemWeight = itemWeight * 2204.62;
        break;
      case "pound":
        itemWeight = itemWeight * 2204.62;
        break;
      case "kg":
        itemWeight = itemWeight * 1000;
        break;
      case "hg":
        itemWeight = itemWeight * 100;
        break;
      case "dag":
        itemWeight = itemWeight * 10;
        break;
      case "gram":
        itemWeight = itemWeight;
        break;
      case "dg":
        itemWeight = itemWeight / 10;
        break;
      case "cg":
        itemWeight = itemWeight / 100;
        break;
      case "mg":
        itemWeight = itemWeight / 1000;
        break;
      default:
        itemWeight = itemWeight;
    }

    itemUnit = value;

    print("$itemWeight gram");
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