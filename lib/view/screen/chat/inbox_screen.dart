import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class InboxScreen extends StatelessWidget {
  final bool isBackButtonExist;
  InboxScreen({this.isBackButtonExist = true});

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(isFirstTime) {
      if(!isGuestMode) {
        Provider.of<ChatProvider>(context, listen: false).initChatInfo(context);
      }
      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(children: [

        // AppBar
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            child: Image.asset(
              Images.toolbar_background, fit: BoxFit.fill, height: 90, width: double.infinity,
              color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: 90 - MediaQuery.of(context).padding.top,
            alignment: Alignment.center,
            child: Row(children: [
              isBackButtonExist
                  ? IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20, color: ColorResources.WHITE),
                onPressed: () => Navigator.of(context).pop(),
              )
                  : SizedBox.shrink(),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Provider.of<ChatProvider>(context).isSearching
                    ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: titilliumRegular.copyWith(color: ColorResources.GAINS_BORO),
                  ),
                  style: titilliumSemiBold.copyWith(color: ColorResources.WHITE, fontSize: Dimensions.FONT_SIZE_LARGE),
                  onChanged: (String query) {
                    Provider.of<ChatProvider>(context, listen: false).filterList(query);
                  },
                )
                    :Text(
                  getTranslated('inbox', context),
                  style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  Provider.of<ChatProvider>(context).isSearching ? Icons.close : Icons.search,
                  size: Dimensions.ICON_SIZE_LARGE,
                  color: ColorResources.WHITE,
                ),
                onPressed: () => Provider.of<ChatProvider>(context, listen: false).toggleSearch(),
              ),
            ]),
          ),
        ]),

        Expanded(
            child: isGuestMode ? NotLoggedInWidget() :  RefreshIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              onRefresh: () async {
                await Provider.of<ChatProvider>(context, listen: false).initChatInfo(context);
              },
              child: Consumer<ChatProvider>(
                builder: (context, chat, child) {
                  return chat.chatInfoModel != null ? chat.uniqueShopList.length != 0 ? ListView.builder(
                    //physics: BouncingScrollPhysics(),
                    itemCount: chat.uniqueShopList.length,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: ClipOval(
                              child: Container(
                                color: Theme.of(context).accentColor,
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder,
                                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}'
                                      '/${chat.uniqueShopList[index].sellerInfo != null ? chat.uniqueShopList[index].sellerInfo : ''}',
                                  fit: BoxFit.cover, height: 50, width: 50,
                                ),
                              ),
                            ),
                            title: Text(chat.uniqueShopList[index].sellerInfo.fName+' '+chat.uniqueShopList[index].sellerInfo.lName, style: titilliumSemiBold),
                            subtitle: Text(chat.uniqueShopList[index].message, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                            trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(DateConverter.isoStringToLocalTimeOnly(chat.uniqueShopList[index].createdAt), style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                              chat.chatInfoModel.lastChat.sellerId == chat.uniqueShopList[index].sellerId ? Container(
                                height: 20,
                                width: 20,
                                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.COLOR_PRIMARY,
                                ),
                                child: Text('1', style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.WHITE)),
                              ) : SizedBox.shrink(),
                            ]),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
                              SellerModel sellerModel = Provider.of<ChatProvider>(context).uniqueShopList[index].sellerInfo;
                              sellerModel.shop = Provider.of<ChatProvider>(context).uniqueShopList[index].shop;
                              return ChatScreen(seller: sellerModel);
                            })),
                          ),
                          Divider(height: 2, color: ColorResources.CHAT_ICON_COLOR),
                        ],
                      );
                    },
                  ) : NoInternetOrDataScreen(isNoInternet: false) : InboxShimmer();
                },
              ),
            ),
          ),
      ]),
    );
  }

}

class InboxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<ChatProvider>(context).uniqueShopList == null,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              CircleAvatar(child: Icon(Icons.person), radius: 30),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Container(height: 15, color: ColorResources.WHITE),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(height: 15, color: ColorResources.WHITE),
                  ]),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 10, width: 30, color: ColorResources.WHITE),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorResources.COLOR_PRIMARY),
                ),
              ])
            ]),
          ),
        );
      },
    );
  }
}

