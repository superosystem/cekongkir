
import 'package:cekongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                labelText: "Berat",
                hintText: "Masukan berat",
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
                  labelText: "Satuan ",
                  hintText: "Search item unit",
                  border: OutlineInputBorder(),
                ),
              ),
              items: const [
                "kg",
                "gram",
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