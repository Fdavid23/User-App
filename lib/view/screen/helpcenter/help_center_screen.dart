import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_expanded_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    List<String> articleList = [
      'My app isn\'t working', 'Ordered by mistake', 'Tracking is not working',
      'Tracking is not working, Ordered by mistake Ordered by mistake',
    ];

    return CustomExpandedAppBar(title: getTranslated('help_center', context), child: ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      children: [

        // Search Field
        TextField(
          style: robotoRegular,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            prefixIcon: Icon(Icons.search, color: ColorResources.getColombiaBlue(context)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.getColombiaBlue(context)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 2, color: ColorResources.getColombiaBlue(context)),
            ),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        // Recommended
        Text(getTranslated('recommended_articles', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: articleList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(articleList[index], style: titilliumSemiBold),
              trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).hintColor, size: Dimensions.ICON_SIZE_DEFAULT),
            );
          },
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

        // Could not find
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('contact_with_customer_care', context), textAlign: TextAlign.center, style: titilliumSemiBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Theme.of(context).hintColor,
          )),
        ),

        CustomButton(buttonText: getTranslated('GET_STARTED', context), onTap: () {}),

      ],
    ));
  }
}

