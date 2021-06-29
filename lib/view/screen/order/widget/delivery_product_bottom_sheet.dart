import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

import 'order_product_widget.dart';

class DeliveryProductBottomSheet extends StatelessWidget {
  final List<OrderDetailsModel> orderDetailsList;
  DeliveryProductBottomSheet({@required this.orderDetailsList});

  @override
  Widget build(BuildContext context) {
    List<int> sellerList = [];
    List<List<OrderDetailsModel>> sellerProductList = [];
    orderDetailsList.forEach((orderDetails) {
      if(!sellerList.contains(orderDetails.productDetails)) {
        sellerList.add(orderDetails.productDetails.userId);
      }
    });
    sellerList.forEach((seller) {
      List<OrderDetailsModel> orderList = [];
      orderDetailsList.forEach((orderDetails) {
        if(seller == orderDetails.productDetails.userId) {
          orderList.add(orderDetails);
        }
      });
      sellerProductList.add(orderList);
    });
    return Column(children: [

      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.cancel, color: ColorResources.RED),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      Text(getTranslated('products_in_the_cart', context), style: robotoRegular),

      ListView.builder(
        itemCount: sellerList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(color: ColorResources.LOW_GREEN, boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3)),
                ]),
                padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(getTranslated('SHIPPING_METHOD', context), textAlign: TextAlign.start, style: titilliumRegular),
                      Text(getTranslated('REGULAR_COURIER', context), textAlign: TextAlign.end, style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: ColorResources.COLOR_PRIMARY,
                      )),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(getTranslated('SELLER', context), textAlign: TextAlign.start, style: titilliumRegular),
                      Text(getTranslated('GADGET_DAILY_OFFICIAL', context), textAlign: TextAlign.end, style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: ColorResources.COLOR_PRIMARY,
                      )),
                    ]),
                  ],
                ),
              ),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemCount: sellerProductList[index].length,
                itemBuilder: (context, i) => OrderProductWidget(orderDetailsModel: sellerProductList[index][i]),
              ),
            ],
          );
        },
      ),

    ]);
  }
}
