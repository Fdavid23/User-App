import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  final CartModel cartModel;
  final int index;
  final bool fromCheckout;
  const CartWidget({Key key, this.cartModel, @required this.index, @required this.fromCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Row(children: [

        !fromCheckout ? InkWell(
          onTap: () => Provider.of<CartProvider>(context, listen: false).toggleSelected(index),
          child: Container(
            width: 15,
            height: 15,
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorResources.getPrimary(context), width: 1),
            ),
            child: Provider.of<CartProvider>(context).isSelectedList[index]
                ? Icon(Icons.done, color: ColorResources.getPrimary(context), size: Dimensions.ICON_SIZE_EXTRA_SMALL)
                : SizedBox.shrink(),
          ),
        ) : SizedBox.shrink(),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.productThumbnailUrl}/${cartModel.image}',
            height: 50,
            width: 50,
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cartModel.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: titilliumBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: ColorResources.getHint(context),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        PriceConverter.convertPrice(context, cartModel.discountedPrice),
                        style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)),
                      ),
                      Container(
                        width: 50,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorResources.getPrimary(context)),
                        ),
                        child: Text(
                          PriceConverter.percentageCalculation(context, cartModel.price, cartModel.discount, cartModel.discountType),
                          textAlign: TextAlign.center,
                          style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getHint(context)),
                        ),
                      ),
                    ],
                  ),
                  !fromCheckout ? Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                        child: QuantityButton(isIncrement: false, index: index, quantity: cartModel.quantity, maxQty: cartModel.maxQuantity),
                      ),
                      Text(cartModel.quantity.toString(), style: titilliumSemiBold),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: QuantityButton(isIncrement: true, index: index, quantity: cartModel.quantity, maxQty: cartModel.maxQuantity),
                      ),
                    ],
                  ) : SizedBox.shrink(),
                ],
              ),
          ),
        ),

        !fromCheckout ? IconButton(
          onPressed: () => Provider.of<CartProvider>(context, listen: false).removeFromCart(index),
          icon: Icon(Icons.cancel, color: ColorResources.RED),
        ) : SizedBox.shrink(),

      ]),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int quantity;
  final int index;
  final int maxQty;
  QuantityButton({@required this.isIncrement, @required this.quantity, @required this.index, @required this.maxQty});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<CartProvider>(context, listen: false).setQuantity(false, index);
        } else if (isIncrement && quantity < maxQty) {
          Provider.of<CartProvider>(context, listen: false).setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? quantity >= maxQty ? ColorResources.getGrey(context)
            : ColorResources.getPrimary(context)
            : quantity > 1
            ? ColorResources.getPrimary(context)
            : ColorResources.getGrey(context),
        size: 20,
      ),
    );
  }
}

