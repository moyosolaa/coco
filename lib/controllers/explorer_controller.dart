import 'dart:convert';
import 'dart:developer';

import 'package:coco/models/categories.dart';
import 'package:coco/state_notifier.dart';
import 'package:coco/views/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ExplorerController extends StateNotifier {
  List<dynamic> results = [];
  List<dynamic> resultCaptions = [];
  List<dynamic> selectedItems = [];
  List<dynamic> selectedItemsID = [];

  final itemss = superCategories.map((e) => MultiSelectItem<SuperCats>(e, e.name)).toList();

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  void onSelectItem(val) {
    selectedItems = val.map((e) => e.name).toList();
    selectedItemsID = val.map((e) => e.id).toList();
    update();
  }

  void removeItem(val) {
    var a = selectedItems.indexWhere((e) => e == val.name);
    selectedItems.removeAt(a);
    selectedItemsID.removeAt(a);
    update();
  }

  Future<void> searchResult() async {
    Loader.showLoader();
    try {
      var res = await http.Client().post(
        Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'),
        headers: headers,
        body: jsonEncode({'category_ids': selectedItemsID, 'querytype': 'getImagesByCats'}),
      );
      var resultDecoded = jsonDecode(res.body);

      var response = await http.Client().post(
        Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'),
        headers: headers,
        body: jsonEncode({'image_ids': resultDecoded, 'querytype': 'getImages'}),
      );
      List<dynamic> imagesResponse = jsonDecode(response.body);

      var caption = await http.Client().post(
        Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'),
        headers: headers,
        body: jsonEncode({'image_ids': resultDecoded, 'querytype': 'getCaptions'}),
      );

      List<dynamic> captions = jsonDecode(caption.body);
      log(captions.toString());

      results = imagesResponse.map((e) => e['coco_url']).toList();
      resultCaptions = captions.map((e) => e['caption']).toList();
      log(results.toString());
      update();
      Get.back();
    } catch (e) {
      const SnackBar(content: Text('Error'));
    }
  }
}
