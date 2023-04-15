import 'package:adblocked_webview/screens/browser_page.dart';
import 'package:adblocked_webview/controllers/data_controller.dart';
import 'package:adblocked_webview/screens/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final dataController = Get.find<DataController>();
  TextEditingController urlController = TextEditingController();
  List<String> historyList = [];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    urlController.text = 'https://www.komikid.com/latest-release';
    // urlController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      /* appBar: AppBar(
        title: const Text('Focus Browser'),
      ), */
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/logo-app.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Focus Browser',
                    style: GoogleFonts.pacifico(fontSize: 25),
                    // style: GoogleFonts.sacramento(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final storage = GetStorage();
                        storage.erase();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text('Clear History'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text('Bookmark'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Get.to(HistoryPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text('History List'),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, shape: StadiumBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "enter your url here..",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // dataController.visitHistory.insert(0, urlController.text);
                  // dataController.urlHistory.insert(0, urlController.text);
                  dataController.addUrlHistory(urlController.text);
                  dataController.addVisitHistory(urlController.text);
                  Get.to(() => BrowserPage(url: urlController.text));
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send),
                    const SizedBox(width: 10),
                    const Text('Access'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: Obx(
                () {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => BrowserPage(
                              url: dataController.urlHistory[index]));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    child:
                                        Text(dataController.urlHistory[index])),
                                GestureDetector(
                                  onTap: () {
                                    dataController.urlHistory.removeAt(index);
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
                    itemCount: dataController.urlHistory.length,
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
