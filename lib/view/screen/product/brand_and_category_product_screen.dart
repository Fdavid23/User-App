import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BrandAndCategoryProductScreen extends StatelessWidget {
  final bool isBrand;
  final String id;
  final String name;
  final String image;
  BrandAndCategoryProductScreen({@required this.isBrand, @required this.id, @required this.name, this.image});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(isBrand, id, context);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

            CustomAppBar(title: name),

            // Brand Details
            isBrand ? Container(
              height: 100,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              color: Theme.of(context).accentColor,
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.brandImageUrl}/$image',
                  width: 80, height: 80, fit: BoxFit.cover,
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text(name, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ]),
            ) : SizedBox.shrink(),

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            // Products
            productProvider.brandOrCategoryProductList.length > 0 ? Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                itemCount: productProvider.brandOrCategoryProductList.length,
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(productModel: productProvider.brandOrCategoryProductList[index]);
                },
              ),
            )
                : Expanded(child: Center(child: productProvider.hasData
                ? ProductShimmer(isEnabled: Provider.of<ProductProvider>(context).brandOrCategoryProductList.length == 0)
                : NoInternetOrDataScreen(isNoInternet: false),
            )),

          ]);
        },
      ),
    );
  }
}