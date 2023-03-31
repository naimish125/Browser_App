import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GoogleProvider extends ChangeNotifier {
  InAppWebViewController? webViewController;
  double progressbar = 0;
  InAppWebViewController? inAppWebViewController;

  void changeprogressbar(double progress) {
    progressbar = progress;
    notifyListeners();
  }

}
