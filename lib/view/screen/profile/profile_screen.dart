import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/user_info_model.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  File file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _updateUserAccount() async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _firstNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName == _firstNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel.lName == _lastNameController.text
        && Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone == _phoneController.text && file == null
        && _passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Change something to update'), backgroundColor: ColorResources.RED));
    }else if (_firstName.isEmpty || _lastName.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)), backgroundColor: ColorResources.RED));
    }else if (_email.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)), backgroundColor: ColorResources.RED));
    }else if (_phoneNumber.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)), backgroundColor: ColorResources.RED));
    } else if((_password.isNotEmpty && _password.length < 6)
        || (_confirmPassword.isNotEmpty && _confirmPassword.length < 6)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Password should be at least 6 character'), backgroundColor: ColorResources.RED));
    } else if(_password != _confirmPassword) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)), backgroundColor: ColorResources.RED));
    }else {
      UserInfoModel updateUserInfoModel = Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
      updateUserInfoModel.method = 'put';
      updateUserInfoModel.fName = _firstNameController.text ?? "";
      updateUserInfoModel.lName = _lastNameController.text ?? "";
      updateUserInfoModel.phone = _phoneController.text ?? '';
      String pass = _passwordController.text ?? '';

      await Provider.of<ProfileProvider>(context, listen: false).updateUserInfo(
        updateUserInfoModel, pass, file, Provider.of<AuthProvider>(context, listen: false).getUserToken(),
      ).then((response) {
        if(response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Updated Successfully'), backgroundColor: Colors.green));
          _passwordController.clear();
          _confirmPasswordController.clear();
          setState(() {});
        }else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(response.message), backgroundColor: Colors.red));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ProfileProvider>(
              builder: (context, profile, child) {
                _firstNameController.text = profile.userInfoModel.fName;
                _lastNameController.text = profile.userInfoModel.lName;
                _emailController.text = profile.userInfoModel.email;
                _phoneController.text = profile.userInfoModel.phone;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [

                    Image.asset(
                      Images.toolbar_background, fit: BoxFit.fill, height: 500,
                      color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : null,
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 35, left: 15),
                      child: Row(children: [
                        CupertinoNavigationBarBackButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(getTranslated('PROFILE', context), style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ]),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 55),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  border: Border.all(color: Colors.white, width: 3),
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: file == null
                                          ? FadeInImage.assetNetwork(
                                              placeholder: Images.placeholder,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${profile.userInfoModel.image}',
                                            )
                                          : Image.file(file, width: 100, height: 100, fit: BoxFit.fill),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: -10,
                                      child: CircleAvatar(
                                        backgroundColor: ColorResources.LIGHT_SKY_BLUE,
                                        radius: 14,
                                        child: IconButton(
                                          onPressed: _choose,
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.edit, color: ColorResources.WHITE, size: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}',
                                style: titilliumSemiBold.copyWith(color: ColorResources.WHITE, fontSize: 20.0),
                              )
                            ],
                          ),

                          SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorResources.getIconBg(context),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),
                                    topRight: Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),
                                  )),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person, color: ColorResources.getLightSkyBlue(context), size: 20),
                                                SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                                Text(getTranslated('FIRST_NAME', context), style: titilliumRegular)
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                            CustomTextField(
                                              textInputType: TextInputType.name,
                                              focusNode: _fNameFocus,
                                              nextNode: _lNameFocus,
                                              hintText: profile.userInfoModel.fName ?? '',
                                              controller: _firstNameController,
                                            ),
                                          ],
                                        )),
                                        SizedBox(width: 15),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.person, color: ColorResources.getLightSkyBlue(context), size: 20),
                                                SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                                Text(getTranslated('LAST_NAME', context), style: titilliumRegular)
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                            CustomTextField(
                                              textInputType: TextInputType.name,
                                              focusNode: _lNameFocus,
                                              nextNode: _emailFocus,
                                              hintText: profile.userInfoModel.lName,
                                              controller: _lastNameController,
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),

                                  // for Email
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.MARGIN_SIZE_DEFAULT,
                                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                                        right: Dimensions.MARGIN_SIZE_DEFAULT),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.alternate_email, color: ColorResources.getLightSkyBlue(context), size: 20),
                                            SizedBox(
                                              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                            ),
                                            Text(getTranslated('EMAIL', context), style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                        CustomTextField(
                                          textInputType: TextInputType.emailAddress,
                                          focusNode: _emailFocus,
                                          nextNode: _phoneFocus,
                                          hintText: profile.userInfoModel.email ?? '',
                                          controller: _emailController,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // for Phone No
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.MARGIN_SIZE_DEFAULT,
                                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                                        right: Dimensions.MARGIN_SIZE_DEFAULT),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.dialpad, color: ColorResources.getLightSkyBlue(context), size: 20),
                                            SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                            Text(getTranslated('PHONE_NO', context), style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                        CustomTextField(
                                          textInputType: TextInputType.number,
                                          focusNode: _phoneFocus,
                                          hintText: profile.userInfoModel.phone ?? "",
                                          nextNode: _addressFocus,
                                          controller: _phoneController,
                                          isPhoneNumber: true,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // for Password
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.MARGIN_SIZE_DEFAULT,
                                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                                        right: Dimensions.MARGIN_SIZE_DEFAULT),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.lock_open, color: ColorResources.getPrimary(context), size: 20),
                                            SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                            Text(getTranslated('PASSWORD', context), style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                        CustomPasswordTextField(
                                          controller: _passwordController,
                                          focusNode: _passwordFocus,
                                          nextNode: _confirmPasswordFocus,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // for  re-enter Password
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.MARGIN_SIZE_DEFAULT,
                                        left: Dimensions.MARGIN_SIZE_DEFAULT,
                                        right: Dimensions.MARGIN_SIZE_DEFAULT),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.lock_open, color: ColorResources.getPrimary(context), size: 20),
                                            SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                                            Text(getTranslated('RE_ENTER_PASSWORD', context), style: titilliumRegular)
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                                        CustomPasswordTextField(
                                          controller: _confirmPasswordController,
                                          focusNode: _confirmPasswordFocus,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE, vertical: Dimensions.MARGIN_SIZE_SMALL),
                            child: !Provider.of<ProfileProvider>(context).isLoading
                                ? CustomButton(onTap: _updateUserAccount, buttonText: getTranslated('UPDATE_ACCOUNT', context))
                                : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
