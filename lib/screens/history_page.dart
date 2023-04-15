import 'package:adblocked_webview/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'browser_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                    () => BrowserPage(url: dataController.visitHistory[index]));
              },
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(child: Text(dataController.visitHistory[index])),
                      GestureDetector(
                        onTap: () {
                          dataController.visitHistory.removeAt(index);
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: dataController.visitHistory.length,
        );
      }),
    );
  }
}
