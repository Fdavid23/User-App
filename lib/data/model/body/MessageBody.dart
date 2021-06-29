class MessageBody {
  String _sellerId;
  String _shopId;
  String _message;

  MessageBody({String sellerId, String shopId, String message}) {
    this._sellerId = sellerId;
    this._shopId = shopId;
    this._message = message;
  }

  String get sellerId => _sellerId;
  String get shopId => _shopId;
  String get message => _message;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _sellerId = json['seller_id'];
    _shopId = json['shop_id'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this._sellerId;
    data['shop_id'] = this._shopId;
    data['message'] = this._message;
    return data;
  }
}
