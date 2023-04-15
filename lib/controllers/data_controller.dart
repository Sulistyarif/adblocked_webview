import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DataController extends GetxController {
  final storage = GetStorage();
  RxList<String> urlHistory = RxList([]);
  RxList<String> visitHistory = RxList([]);

  addUrlHistory(String url) {
    urlHistory.insert(0, url);
    // print(jsonEncode(urlHistory));
    storage.write('url_history', jsonEncode(urlHistory));
  }

  addVisitHistory(String url) {
    visitHistory.insert(0, url);
    // print(jsonEncode(visitHistory));
    storage.write('visit_history', jsonEncode(visitHistory));
  }

  loadHistory() {
    String? jsonUrlHistory = storage.read('url_history');
    if (jsonUrlHistory != null) {
      List<String> parsedUrlHistory =
          json.decode(jsonUrlHistory).cast<String>().toList();
      urlHistory.value = parsedUrlHistory;
    }

    String? jsonVisitHistory = storage.read('visit_history');
    if (jsonVisitHistory != null) {
      List<String> parsedVisitHistory =
          json.decode(jsonVisitHistory).cast<String>().toList();
      visitHistory.value = parsedVisitHistory;
    }
  }
}
