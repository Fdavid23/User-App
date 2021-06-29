import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';

class ChatInfoModel {
  LastChat _lastChat;
  List<ChatModel> _chatList;
  List<UniqueShops> _uniqueShops;

  ChatInfoModel(
      {LastChat lastChat,
        List<ChatModel> chatList,
        List<UniqueShops> uniqueShops}) {
    this._lastChat = lastChat;
    this._chatList = chatList;
    this._uniqueShops = uniqueShops;
  }

  LastChat get lastChat => _lastChat;
  List<ChatModel> get chatList => _chatList;
  List<UniqueShops> get uniqueShops => _uniqueShops;

  ChatInfoModel.fromJson(Map<String, dynamic> json) {
    _lastChat = json['last_chat'] != null
        ? new LastChat.fromJson(json['last_chat'])
        : null;
    if (json['chat_list'] != null) {
      _chatList = [];
      json['chat_list'].forEach((v) {
        _chatList.add(new ChatModel.fromJson(v));
      });
    }
    if (json['unique_shops'] != null) {
      _uniqueShops = [];
      json['unique_shops'].forEach((v) {
        _uniqueShops.add(new UniqueShops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._lastChat != null) {
      data['last_chat'] = this._lastChat.toJson();
    }
    if (this._chatList != null) {
      data['chat_list'] = this._chatList.map((v) => v.toJson()).toList();
    }
    if (this._uniqueShops != null) {
      data['unique_shops'] = this._uniqueShops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastChat {
  int _id;
  int _userId;
  int _sellerId;
  String _message;
  int _sentByCustomer;
  int _sentBySeller;
  int _seenByCustomer;
  int _seenBySeller;
  int _status;
  String _createdAt;
  String _updatedAt;
  int _shopId;

  LastChat(
      {int id,
        int userId,
        int sellerId,
        String message,
        int sentByCustomer,
        int sentBySeller,
        int seenByCustomer,
        int seenBySeller,
        int status,
        String createdAt,
        String updatedAt,
        int shopId}) {
    this._id = id;
    this._userId = userId;
    this._sellerId = sellerId;
    this._message = message;
    this._sentByCustomer = sentByCustomer;
    this._sentBySeller = sentBySeller;
    this._seenByCustomer = seenByCustomer;
    this._seenBySeller = seenBySeller;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._shopId = shopId;
  }

  int get id => _id;
  int get userId => _userId;
  int get sellerId => _sellerId;
  String get message => _message;
  int get sentByCustomer => _sentByCustomer;
  int get sentBySeller => _sentBySeller;
  int get seenByCustomer => _seenByCustomer;
  int get seenBySeller => _seenBySeller;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get shopId => _shopId;

  LastChat.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _sellerId = json['seller_id'];
    _message = json['message'];
    _sentByCustomer = json['sent_by_customer'];
    _sentBySeller = json['sent_by_seller'];
    _seenByCustomer = json['seen_by_customer'];
    _seenBySeller = json['seen_by_seller'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['seller_id'] = this._sellerId;
    data['message'] = this._message;
    data['sent_by_customer'] = this._sentByCustomer;
    data['sent_by_seller'] = this._sentBySeller;
    data['seen_by_customer'] = this._seenByCustomer;
    data['seen_by_seller'] = this._seenBySeller;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['shop_id'] = this._shopId;
    return data;
  }
}

class UniqueShops {
  int _id;
  int _userId;
  int _sellerId;
  String _message;
  int _sentByCustomer;
  int _sentBySeller;
  int _seenByCustomer;
  int _seenBySeller;
  int _status;
  String _createdAt;
  String _updatedAt;
  int _shopId;
  SellerModel _sellerInfo;
  Shop _shop;

  UniqueShops(
      {int id,
        int userId,
        int sellerId,
        String message,
        int sentByCustomer,
        int sentBySeller,
        int seenByCustomer,
        int seenBySeller,
        int status,
        String createdAt,
        String updatedAt,
        int shopId,
        SellerModel sellerInfo,
        Shop shop}) {
    this._id = id;
    this._userId = userId;
    this._sellerId = sellerId;
    this._message = message;
    this._sentByCustomer = sentByCustomer;
    this._sentBySeller = sentBySeller;
    this._seenByCustomer = seenByCustomer;
    this._seenBySeller = seenBySeller;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._shopId = shopId;
    this._sellerInfo = sellerInfo;
    this._shop = shop;
  }

  int get id => _id;
  int get userId => _userId;
  int get sellerId => _sellerId;
  String get message => _message;
  int get sentByCustomer => _sentByCustomer;
  int get sentBySeller => _sentBySeller;
  int get seenByCustomer => _seenByCustomer;
  int get seenBySeller => _seenBySeller;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get shopId => _shopId;
  SellerModel get sellerInfo => _sellerInfo;
  Shop get shop => _shop;

  UniqueShops.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _sellerId = json['seller_id'];
    _message = json['message'];
    _sentByCustomer = json['sent_by_customer'];
    _sentBySeller = json['sent_by_seller'];
    _seenByCustomer = json['seen_by_customer'];
    _seenBySeller = json['seen_by_seller'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shopId = json['shop_id'];
    _sellerInfo = json['seller_info'] != null
        ? new SellerModel.fromJson(json['seller_info'])
        : null;
    _shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['seller_id'] = this._sellerId;
    data['message'] = this._message;
    data['sent_by_customer'] = this._sentByCustomer;
    data['sent_by_seller'] = this._sentBySeller;
    data['seen_by_customer'] = this._seenByCustomer;
    data['seen_by_seller'] = this._seenBySeller;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['shop_id'] = this._shopId;
    if (this._sellerInfo != null) {
      data['seller_info'] = this._sellerInfo.toJson();
    }
    if (this._shop != null) {
      data['shop'] = this._shop.toJson();
    }
    return data;
  }
}