import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_expanded_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<BannerProvider>(context, listen: false).initFooterBannerList(context);


    return CustomExpandedAppBar(title: getTranslated('offers', context), child: Consumer<BannerProvider>(
      builder: (context, banner, child) {
        return banner.footerBannerList != null ? banner.footerBannerList.length != 0 ? RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<BannerProvider>(context, listen: false).initFooterBannerList(context);
          },
          child: ListView.builder(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            itemCount: Provider.of<BannerProvider>(context).footerBannerList.length,
            itemBuilder: (context, index) {

              return InkWell(
                onTap: () => _launchUrl(banner.footerBannerList[index].url),
                child: Container(
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                          '/${banner.footerBannerList[index].photo}',
                      fit: BoxFit.fill,
                      height: 150,
                    ),
                  ),
                ),
              );
            },
          ),
        ) : Center(child: Text('No banner available')) : OfferShimmer();
      },
    ));
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class OfferShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<BannerProvider>(context).footerBannerList == null,
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorResources.WHITE),
          ),
        );
      },
    );
  }
}

