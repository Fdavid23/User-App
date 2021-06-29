import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class OrderScreen extends StatelessWidget {
  final bool isBacButtonExist;
  OrderScreen({this.isBacButtonExist = true});

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(isFirstTime) {
      if(!isGuestMode) {
        Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
      }

      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('ORDER', context), isBackButtonExist: isBacButtonExist),
          isGuestMode
              ? SizedBox()
              : Provider.of<OrderProvider>(context).pendingList != null
                  ? Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) => Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Row(
                          children: [
                            OrderTypeButton(text: getTranslated('PENDING', context), index: 0, orderList: orderProvider.pendingList),
                            SizedBox(width: 10),
                            OrderTypeButton(text: getTranslated('DELIVERED', context), index: 1, orderList: orderProvider.deliveredList),
                            SizedBox(width: 10),
                            OrderTypeButton(text: getTranslated('CANCELED', context), index: 2, orderList: orderProvider.canceledList),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
          isGuestMode
              ? Expanded(child: NotLoggedInWidget())
              : Provider.of<OrderProvider>(context).pendingList != null
                  ? Consumer<OrderProvider>(
                      builder: (context, order, child) {
                        List<OrderModel> orderList = [];
                        if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 0) {
                          orderList = order.pendingList;
                        } else if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 1) {
                          orderList = order.deliveredList;
                        } else if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 2) {
                          orderList = order.canceledList;
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                            onRefresh: () async {
                              await Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
                            },
                            child: ListView.builder(
                              itemCount: orderList.length,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (context, index) => OrderWidget(orderModel: orderList[index]),
                            ),
                          ),
                        );
                      },
                    )
                  : Expanded(child: OrderShimmer()),
        ],
      ),
    );
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).accentColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;
  final List<OrderModel> orderList;

  OrderTypeButton({@required this.text, @required this.index, @required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () => Provider.of<OrderProvider>(context, listen: false).setIndex(index),
        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == index ? ColorResources.getPrimary(context) : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(text + '(${orderList.length})',
              style: titilliumBold.copyWith(color: Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == index
                  ? Theme.of(context).accentColor : ColorResources.getPrimary(context))),
        ),
      ),
    );
  }
}
