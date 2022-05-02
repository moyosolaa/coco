import 'dart:convert';

import 'package:coco/models/categories.dart';
import 'package:coco/views/loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ExplorerController extends GetxController {
  RxList<dynamic> results = [].obs;
  List<dynamic> selectedItems = [];

  final itemss = superCategories.map((e) => MultiSelectItem<SuperCats>(e, e.name)).toList();

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  void onSelectItem(val) {
    selectedItems = val.map((e) => e.name).toList();
  }

  Future<void> searchResult() async {
    Loader.showLoader();
    var res = await http.Client().post(
      Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'),
      headers: headers,
      body: jsonEncode({'category_ids': selectedItems, 'querytype': 'getImagesByCats'}),
    );
    var resultDecoded = jsonDecode(res.body);
    print('dfffffffffffffffffffffssssssssssssssssssssssf');
    print(resultDecoded.toString());

    var response = await http.Client().post(
      Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'),
      headers: headers,
      body: {'image_ids': resultDecoded[0], 'querytype': 'getImages'},
    );
    var imagesResponse = jsonDecode(response.body);
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    print(imagesResponse.toString());

    results = imagesResponse;
    Get.back();
  }
}
