import 'package:cekongkir/app/modules/home/controllers/home_controller.dart';
import 'package:cekongkir/app/widgets/city_widget.dart';
import 'package:cekongkir/app/widgets/item_weight_widget.dart';
import 'package:cekongkir/app/widgets/province_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Cost Checker'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const ProvinceWidget(type: "from"),
            Obx(() => controller.hiddenHometown.isTrue
                ? const SizedBox()
                : CityWidget(provinceId: controller.homeProvinceId.value, type: "from"),
            ),
            const ProvinceWidget(type: "destination"),
            Obx(() => controller.hiddenHometown.isTrue
                  ? const SizedBox()
                  : CityWidget(provinceId: controller.destinationProvinceId.value, type: "destination"),
            ),
            const ItemWeightWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: DropdownSearch<Map<String, dynamic>>(
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Courier Name",
                    hintText: "Choose your courier",
                    border: OutlineInputBorder(),
                  ),
                ),
                items: const [
                  {
                    "code": "jne",
                    "name": "Jalur Nugraha Ekakurir (JNE)",
                  },
                  {
                    "code": "tiki",
                    "name": "Titipan Kilat (TIKI)",
                  },
                  {
                    "code": "pos",
                    "name": "Perusahaan Opsional Surat (POS)",
                  },
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.courier.value = value["code"];
                    controller.showButton();
                  } else {
                    controller.hiddenButton.value = true;
                    controller.courier.value = "";
                  }
                },
                itemAsString: (item) => "${item['name']}",
              ),
            ),
            Obx(() => controller.hiddenButton.isTrue
                  ? const SizedBox()
                  : ElevatedButton(
                onPressed: () => controller.costSender(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20), backgroundColor: Colors.red[900],
                ),
                child: const Text("CHECK SHIPPING COST"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
