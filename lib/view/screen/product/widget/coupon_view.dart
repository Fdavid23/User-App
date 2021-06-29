import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

class CouponView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(getTranslated('coupon_voucher', context), style: robotoBold),
      SizedBox(height: 10),
      Stack(fit: StackFit.loose, children: [
        Image.asset(Images.coupon_banner_image, fit: BoxFit.contain),
        Row(children: [
          Expanded(
            flex: 7,
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('10% COUPON', style: titilliumBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                  color: ColorResources.WHITE,
                )),
                Text('New User Only', style: robotoRegular.copyWith(color: ColorResources.WHITE)),
              ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: InkWell(
                onTap: () {
                  print(getTranslated('grab_now', context));
                },
                child: Container(
                  height: 20,
                  width: 70,
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: ColorResources.WHITE),
                  child: Text(getTranslated('grab_now', context), style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                ),
              ),
            ),
          ),
        ]),
      ]),
    ]);
  }
}
