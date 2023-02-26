import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cekongkir/app/province/province_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DropdownSearch<ProvinceModel>(
              asyncItems: (String filter) async {
                Uri url =
                    Uri.parse("https://api.rajaongkir.com/starter/province");
                try {
                  final response = await http.get(
                    url,
                    headers: {
                      "key": dotenv.get('BACKEND_API_KEY'),
                    },
                  );
                  var data = json.decode(response.body) as Map<String, dynamic>;
                  var statusCode = data['rajaongkir']['status']["code"];
                  if (statusCode != 200) {
                    throw data['rajaongkir']['status']["description"];
                  }
                  var listAllProvince =
                      data["rajaongkir"]["results"] as List<dynamic>;
                  var models = ProvinceModel.fromJsonList(listAllProvince);
                  return models;
                } catch (err) {
                  return List<ProvinceModel>.empty();
                }
              },
              popupProps: const PopupProps.menu(
                showSearchBox: true,
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "From",
                  hintText: "province in country",
                ),
              ),
              // ignore: avoid_print
              onChanged: (value) => print(value),
              itemAsString: (data) => data.province.toString(),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
