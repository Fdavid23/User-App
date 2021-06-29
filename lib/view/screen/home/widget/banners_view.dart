import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BannersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(
      builder: (context, bannerProvider, child) {
        double _width = MediaQuery.of(context).size.width;
        return Container(
          width: _width,
          height: _width * 0.3,
          child: bannerProvider.mainBannerList != null ? bannerProvider.mainBannerList.length != 0 ? Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    Provider.of<BannerProvider>(context, listen: false).setCurrentIndex(index);
                  },
                ),
                itemCount: bannerProvider.mainBannerList.length == 0 ? 1 : bannerProvider.mainBannerList.length,
                itemBuilder: (context, index, _) {
                  return InkWell(
                    onTap: () => _launchUrl(bannerProvider.mainBannerList[index].url),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                              '/${bannerProvider.mainBannerList[index].photo}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerProvider.mainBannerList.map((banner) {
                    int index = bannerProvider.mainBannerList.indexOf(banner);
                    return TabPageSelectorIndicator(
                      backgroundColor: index == bannerProvider.currentIndex ? Colors.orange : ColorResources.WHITE,
                      borderColor: index == bannerProvider.currentIndex ? Colors.orange : Colors.orange,
                      size: 10,
                    );
                  }).toList(),
                ),
              ),
            ],
          ) : Center(child: Text('No banner available')) : Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: bannerProvider.mainBannerList == null,
            child: Container(margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
            )),
          ),
        );
      },
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
