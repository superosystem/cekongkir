import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';

class ItemWeightWidget extends GetView<HomeController> {
  const ItemWeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.weightCalc,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Item Weight",
                hintText: "Input Weight",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.changeWeight(value),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 150,
            child: DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Item Unit",
                  hintText: "Search item unit",
                  border: OutlineInputBorder(),
                ),
              ),
              items: const [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              selectedItem: "gram",
              onChanged: (value) => controller.changeUnit(value!),
            ),
          ),
        ],
      ),
    );
  }
}