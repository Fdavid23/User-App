import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_loader.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String orderID;
  final String customerID;
  PaymentScreen({@required this.orderID, @required this.customerID});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedUrl;
  double value = 0.0;
  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl = '${AppConstants.BASE_URL}customer/payment-mobile?order_id=${widget.orderID}&&customer_id=${widget.customerID}';
    print(selectedUrl);

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [

            CustomAppBar(title: getTranslated('PAYMENT', context), onBackPressed: () => _exitApp(context)),

            Expanded(
              child: Stack(
                children: [
                  WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: '${AppConstants.BASE_URL}customer/payment-mobile?order_id=${widget.orderID}&&customer_id=${widget.customerID}',
                    gestureNavigationEnabled: true,
                    userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.future.then((value) => controllerGlobal = value);
                      _controller.complete(webViewController);
                    },
                    onPageStarted: (String url) {
                      if(url.contains(AppConstants.BASE_URL)) {
                        bool _isSuccess = url.contains('success');
                        bool _isFailed = url.contains('fail');
                        print('Page started loading: $url');
                        setState(() {
                          _isLoading = true;
                        });
                        if (_isSuccess) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.done,
                            title: getTranslated('payment_done', context),
                            description: getTranslated('your_payment_successfully_done', context),
                          ), dismissible: false, isFlip: true);
                        } else if (_isFailed) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.clear,
                            title: getTranslated('payment_failed', context),
                            description: getTranslated('your_payment_failed', context),
                            isFailed: true,
                          ), dismissible: false, isFlip: true);
                        } else if (url == '${AppConstants.BASE_URL}cancel') {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
                          showAnimatedDialog(context, MyDialog(
                            icon: Icons.clear,
                            title: getTranslated('payment_cancelled', context),
                            description: getTranslated('your_payment_cancelled', context),
                            isFailed: true,
                          ), dismissible: false, isFlip: true);
                        }
                      }
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),

                  _isLoading ? Center(
                    child: CustomLoader(color: ColorResources.COLOR_PRIMARY),
                  ) : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
      showAnimatedDialog(context, MyDialog(
        icon: Icons.clear,
        title: getTranslated('payment_cancelled', context),
        description: getTranslated('your_payment_cancelled', context),
        isFailed: true,
      ), dismissible: false, isFlip: true);
      return Future.value(true);
    }
  }
}
