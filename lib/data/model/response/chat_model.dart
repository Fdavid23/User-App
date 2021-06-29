class ChatModel {
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

  ChatModel(
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

  ChatModel.fromJson(Map<String, dynamic> json) {
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
