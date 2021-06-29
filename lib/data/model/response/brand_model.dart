class BrandModel {
  int _id;
  String _name;
  String _image;
  int _status;
  String _createdAt;
  String _updatedAt;
  int _brandProductsCount;

  BrandModel(
      {int id,
        String name,
        String image,
        int status,
        String createdAt,
        String updatedAt,
        int brandProductsCount}) {
    this._id = id;
    this._name = name;
    this._image = image;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._brandProductsCount = brandProductsCount;
  }

  int get id => _id;
  String get name => _name;
  String get image => _image;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get brandProductsCount => _brandProductsCount;

  BrandModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _brandProductsCount = json['brand_products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['brand_products_count'] = this._brandProductsCount;
    return data;
  }
}
