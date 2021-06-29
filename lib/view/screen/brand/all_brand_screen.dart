import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/brand_view.dart';
import 'package:provider/provider.dart';

class AllBrandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20, color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(getTranslated('all_brand', context), style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE)),
        actions: [
          PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(enabled: false, child: Text(getTranslated('sort_by', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.HINT_TEXT_COLOR))),
              CheckedPopupMenuItem(
                value: 0,
                checked: Provider.of<BrandProvider>(context, listen: false).isTopBrand,
                child: Text(getTranslated('top_brand', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
              CheckedPopupMenuItem(
                value: 1,
                checked: Provider.of<BrandProvider>(context, listen: false).isAZ,
                child: Text(getTranslated('alphabetically_az', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
              CheckedPopupMenuItem(
                value: 2,
                checked: Provider.of<BrandProvider>(context, listen: false).isZA,
                child: Text(getTranslated('alphabetically_za', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              ),
            ];
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          offset: Offset(0, 45),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(Images.filter_image, color: ColorResources.WHITE),
          ),
          onSelected: (value) {
            Provider.of<BrandProvider>(context, listen: false).sortBrandLis(value);
          },
        )],
      ),

      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: BrandView(isHomePage: false),
      ),
    );
  }
}
