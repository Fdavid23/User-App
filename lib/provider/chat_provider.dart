import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/MessageBody.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/chat_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepo chatRepo;
  ChatProvider({@required this.chatRepo});

  ChatInfoModel _chatInfoModel;
  List<ChatModel> _chatList;
  File _imageFile;
  bool _isSendButtonActive = false;
  List<UniqueShops> _uniqueShopList;
  List<UniqueShops> _uniqueShopAllList;
  bool _isSearching = false;

  List<ChatModel> get chatList => _chatList;
  File get imageFile => _imageFile;
  bool get isSendButtonActive => _isSendButtonActive;
  ChatInfoModel get chatInfoModel => _chatInfoModel;
  List<UniqueShops> get uniqueShopList => _uniqueShopList;
  bool get isSearching => _isSearching;

  Future<void> initChatInfo(BuildContext context) async {
    ApiResponse apiResponse = await chatRepo.getChatInfo();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _chatInfoModel = ChatInfoModel.fromJson(apiResponse.response.data);
      _uniqueShopList = [];
      _uniqueShopAllList = [];
      if(_chatInfoModel.uniqueShops != null) {
        _chatInfoModel.uniqueShops.forEach((uniqueShop) {
          _uniqueShopList.add(uniqueShop);
          _uniqueShopAllList.add(uniqueShop);
        });
      }else {
        _chatInfoModel = ChatInfoModel(uniqueShops: []);
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> initChatList(int sellerID, BuildContext context) async {
    _chatList = null;
    notifyListeners();
    ApiResponse apiResponse = await chatRepo.getChatList(sellerID.toString());
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _chatList = [];
      apiResponse.response.data.forEach((chat) => _chatList.add(ChatModel.fromJson(chat)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void sendMessage(MessageBody messageBody, BuildContext context) async {
    ApiResponse apiResponse = await chatRepo.sendMessage(messageBody);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _chatList.add(ChatModel(sellerId: int.parse(messageBody.shopId), message: messageBody.message, sentByCustomer: 1, sentBySeller: 0,
          seenByCustomer: 0, seenBySeller:1, shopId: int.parse(messageBody.shopId), createdAt: DateConverter.localDateToIsoString(DateTime.now())));
      notifyListeners();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _imageFile = null;
    _isSendButtonActive = false;
    notifyListeners();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }

  void setImage(File image) {
    _imageFile = image;
    _isSendButtonActive = true;
    notifyListeners();
  }

  void removeImage(String text) {
    _imageFile = null;
    text.isEmpty ? _isSendButtonActive = false : _isSendButtonActive = true;
    notifyListeners();
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void filterList(String query) {
    _uniqueShopList.clear();
    if(query.isNotEmpty) {
      _uniqueShopAllList.forEach((uniqueShop) {
        if ((uniqueShop.sellerInfo.fName + ' ' + uniqueShop.sellerInfo.lName).toLowerCase().contains(query.toLowerCase())) {
          _uniqueShopList.add(uniqueShop);
        }
      });
    }else {
      _uniqueShopList.addAll(_uniqueShopAllList);
    }
    notifyListeners();
  }
}
