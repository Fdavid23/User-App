import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/widget/notification_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final bool isBacButtonExist;
  NotificationScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false).initNotificationList(context);


    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('notification', context), isBackButtonExist: isBacButtonExist),

        Expanded(
          child: Consumer<NotificationProvider>(
            builder: (context, notification, child) {
              return notification.notificationList != null ? notification.notificationList.length != 0 ? RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: () async {
                  await Provider.of<NotificationProvider>(context, listen: false).initNotificationList(context);
                },
                child: ListView.builder(
                  itemCount: Provider.of<NotificationProvider>(context).notificationList.length,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => showDialog(context: context, builder: (context) => NotificationDialog(notificationModel: notification.notificationList[index])),
                      child: Container(
                        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                        color: ColorResources.getGrey(context),
                        child: ListTile(
                          leading: ClipOval(child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.notificationImageUrl}/${notification.notificationList[index].image}',
                            height: 50, width: 50, fit: BoxFit.cover,
                          )),
                          title: Text(notification.notificationList[index].title, style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          )),
                          subtitle: Text(
                            DateFormat('hh:mm  dd/MM/yyyy').format(DateConverter.isoStringToLocalDate(notification.notificationList[index].createdAt)),
                            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getHint(context)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ) : NoInternetOrDataScreen(isNoInternet: false) : NotificationShimmer();
            },
          ),
        ),

      ]),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: Provider.of<NotificationProvider>(context).notificationList == null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle: Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}

