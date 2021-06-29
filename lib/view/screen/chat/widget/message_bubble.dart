import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel chat;
  final String sellerImage;
  final Function onProfileTap;
  MessageBubble({@required this.chat, @required this.sellerImage, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    bool isMe = chat.sentByCustomer == 1;
    String dateTime = DateConverter.isoStringToLocalTimeOnly(chat.createdAt);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe ? SizedBox.shrink() : InkWell(onTap: onProfileTap, child: ClipOval(child: Container(
          color: Theme.of(context).accentColor,
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/$sellerImage',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ))),
        Flexible(
          child: Container(
              margin: isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: isMe ? ColorResources.getImageBg(context) : Theme.of(context).accentColor,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                !isMe? Text(dateTime, style: titilliumRegular.copyWith(
                  fontSize: 8,
                  color: ColorResources.getHint(context),
                )) : SizedBox.shrink(),
                chat.message.isNotEmpty ? Text(chat.message, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)) : SizedBox.shrink(),
                //chat.image != null ? Image.file(chat.image) : SizedBox.shrink(),
              ]),
          ),
        ),
      ],
    );
  }
}
