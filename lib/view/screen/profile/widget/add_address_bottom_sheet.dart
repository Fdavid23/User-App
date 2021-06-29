import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddAddressBottomSheet extends StatefulWidget {
  @override
  _AddAddressBottomSheetState createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final FocusNode _buttonAddressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
              return Container(
                padding: EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    )
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                ),
                alignment: Alignment.center,
                child: DropdownButtonFormField<String>(
                  value: profileProvider.addressType,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(border: InputBorder.none),
                  iconSize: 24,
                  elevation: 16,
                  style: titilliumRegular,
                  //underline: SizedBox(),

                  onChanged: profileProvider.updateCountryCode,
                  items: profileProvider.addressTypeList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: titilliumRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                    );
                  }).toList(),
                ),
              );
            }),
            Divider(thickness: 0.7, color: ColorResources.GREY),
            CustomTextField(
              hintText: getTranslated('ENTER_YOUR_ADDRESS', context),
              controller: _addressController,
              textInputType: TextInputType.streetAddress,
              focusNode: _buttonAddressFocus,
              nextNode: _cityFocus,
              textInputAction: TextInputAction.next,
            ),
            Divider(thickness: 0.7, color: ColorResources.GREY),
            CustomTextField(
              hintText: getTranslated('ENTER_YOUR_CITY', context),
              controller: _cityNameController,
              textInputType: TextInputType.streetAddress,
              focusNode: _cityFocus,
              nextNode: _zipCodeFocus,
              textInputAction: TextInputAction.next,
            ),
            Divider(thickness: 0.7, color: ColorResources.GREY),
            CustomTextField(
              hintText: getTranslated('ENTER_YOUR_ZIP_CODE', context),
              isPhoneNumber: true,
              controller: _zipCodeController,
              textInputType: TextInputType.number,
              focusNode: _zipCodeFocus,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 30),
            Provider.of<ProfileProvider>(context).addAddressErrorText != null
                ? Text(Provider.of<ProfileProvider>(context).addAddressErrorText, style: titilliumRegular.copyWith(color: ColorResources.RED))
                : SizedBox.shrink(),
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return profileProvider.isLoading
                    ? CircularProgressIndicator(key: Key(''), valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))
                    : CustomButton(
                  buttonText: getTranslated('UPDATE_ADDRESS', context),
                  onTap: () {
                    _addAddress();
                  },
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _addAddress() {
    if(Provider.of<ProfileProvider>(context, listen: false).addressType == Provider.of<ProfileProvider>(context, listen: false).addressTypeList[0]) {
      Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(getTranslated('SELECT_ADDRESS_TYPE', context));
    } else if(_addressController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context));
    } else if(_cityNameController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(getTranslated('CITY_FIELD_MUST_BE_REQUIRED', context));
    } else if(_zipCodeController.text.isEmpty) {
      Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context));
    } else {
      Provider.of<ProfileProvider>(context, listen: false).setAddAddressErrorText(null);
      AddressModel addressModel = AddressModel();
      addressModel.contactPersonName = 'x';
      addressModel.addressType = Provider.of<ProfileProvider>(context, listen: false).addressType;
      addressModel.city = _cityNameController.text;
      addressModel.address = _addressController.text;
      addressModel.zip = _zipCodeController.text;
      addressModel.phone = '0';

      Provider.of<ProfileProvider>(context, listen: false).addAddress(addressModel, route);
    }
  }

  route(bool isRoute, String message) {
    if (isRoute) {
      _cityNameController.clear();
      _zipCodeController.clear();
      Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
      Navigator.pop(context);
    }
  }
}
