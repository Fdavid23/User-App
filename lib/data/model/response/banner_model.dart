class BannerModel {
  int _id;
  String _photo;
  String _bannerType;
  int _published;
  String _createdAt;
  String _updatedAt;
  String _url;

  BannerModel({int id, String photo, String bannerType, int published, String createdAt, String updatedAt, String url}) {
    this._id = id;
    this._photo = photo;
    this._bannerType = bannerType;
    this._published = published;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._url = url;
  }

  int get id => _id;
  String get photo => _photo;
  String get bannerType => _bannerType;
  int get published => _published;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get url => _url;

  BannerModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _photo = json['photo'];
    _bannerType = json['banner_type'];
    _published = json['published'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['photo'] = this._photo;
    data['banner_type'] = this._bannerType;
    data['published'] = this._published;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['url'] = this._url;
    return data;
  }
}
