import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../provider/Google_Provider.dart';

class GoogleScreen extends StatefulWidget {
  const GoogleScreen({Key? key}) : super(key: key);

  @override
  State<GoogleScreen> createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  GoogleProvider? GoogleProvidertrue;
  GoogleProvider? GoogleProviderfalse;
  TextEditingController search2 = TextEditingController();
  PullToRefreshController? pull;
  @override
  void initState() {
    super.initState();
    pull = PullToRefreshController(
      onRefresh: () {
        GoogleProvidertrue!.webViewController!.reload();
      },
    );
  }

  Widget build(BuildContext context) {
    GoogleProvidertrue = Provider.of<GoogleProvider>(context, listen: true);
    GoogleProviderfalse = Provider.of<GoogleProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    GoogleProvidertrue!.inAppWebViewController!.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black38,
                    size: 23,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black12,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: IconButton(
                              onPressed: () {
                                var search = search2.text;
                                GoogleProvidertrue!.inAppWebViewController!
                                    .loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(
                                        "https://www.google.com/search?q=$search"),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                                size: 23,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: search2,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,

                                border: InputBorder.none,
                                hintText: "Search URL",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mic_none_outlined,
                                color: Colors.black38,
                                size: 23,
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        GoogleProvidertrue!.inAppWebViewController!.goForward();
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.black38,
                        size: 23,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        GoogleProvidertrue!.inAppWebViewController!.reload();
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 23,
                      ),
                    ),
                  ],
                )
              ],
            ),
            LinearProgressIndicator(
              value: GoogleProvidertrue!.progressbar,
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse("https://www.google.com/"),
                ),
                pullToRefreshController: pull!,
                onWebViewCreated: (controller) {
                  GoogleProvidertrue!.inAppWebViewController = controller;
                },
                onLoadError: (controller, url, code, message) {
                  GoogleProvidertrue!.inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  GoogleProvidertrue!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  GoogleProvidertrue!.inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  GoogleProviderfalse!.changeprogressbar(progress / 100);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

