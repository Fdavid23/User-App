class ShippingMethodModel {
  int _id;
  int _creatorId;
  String _creatorType;
  String _title;
  double _cost;
  String _duration;
  int _status;
  String _createdAt;
  String _updatedAt;

  ShippingMethodModel(
      {int id,
        int creatorId,
        String creatorType,
        String title,
        double cost,
        String duration,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._creatorId = creatorId;
    this._creatorType = creatorType;
    this._title = title;
    this._cost = cost;
    this._duration = duration;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  int get creatorId => _creatorId;
  String get creatorType => _creatorType;
  String get title => _title;
  double get cost => _cost;
  String get duration => _duration;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _creatorId = json['creator_id'];
    _creatorType = json['creator_type'];
    _title = json['title'];
    _cost = json['cost'].toDouble();
    _duration = json['duration'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['creator_id'] = this._creatorId;
    data['creator_type'] = this._creatorType;
    data['title'] = this._title;
    data['cost'] = this._cost;
    data['duration'] = this._duration;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
