class ReviewBody {
  String _productId;
  String _comment;
  String _rating;
  List<String> _fileUpload;

  ReviewBody(
      {String productId,
        String comment,
        String rating,
        List<String> fileUpload}) {
    this._productId = productId;
    this._comment = comment;
    this._rating = rating;
    this._fileUpload = fileUpload;
  }

  String get productId => _productId;
  String get comment => _comment;
  String get rating => _rating;
  List<String> get fileUpload => _fileUpload;

  ReviewBody.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _comment = json['comment'];
    _rating = json['rating'];
    _fileUpload = json['fileUpload'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this._productId;
    data['comment'] = this._comment;
    data['rating'] = this._rating;
    data['fileUpload'] = this._fileUpload;
    return data;
  }
}
