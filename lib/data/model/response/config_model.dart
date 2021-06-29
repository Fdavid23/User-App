class ConfigModel {
  BaseUrls _baseUrls;
  StaticUrls _staticUrls;
  List<CurrencyList> _currencyList;
  Language _language;

  ConfigModel({BaseUrls baseUrls, StaticUrls staticUrls, List<CurrencyList> currencyList, Language language}) {
    this._baseUrls = baseUrls;
    this._staticUrls = staticUrls;
    this._currencyList = currencyList;
    this._language = language;
  }

  BaseUrls get baseUrls => _baseUrls;
  StaticUrls get staticUrls => _staticUrls;
  List<CurrencyList> get currencyList => _currencyList;
  Language get language => _language;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    _baseUrls = json['base_urls'] != null ? new BaseUrls.fromJson(json['base_urls']) : null;
    _staticUrls = json['static_urls'] != null ? new StaticUrls.fromJson(json['static_urls']) : null;
    if (json['currency_list'] != null) {
      _currencyList = [];
      json['currency_list'].forEach((v) { _currencyList.add(new CurrencyList.fromJson(v)); });
    }
    _language = json['language'] != null ? new Language.fromJson(json['language']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._baseUrls != null) {
      data['base_urls'] = this._baseUrls.toJson();
    }
    if (this._staticUrls != null) {
      data['static_urls'] = this._staticUrls.toJson();
    }
    if (this._currencyList != null) {
      data['currency_list'] = this._currencyList.map((v) => v.toJson()).toList();
    }
    if (this._language != null) {
      data['language'] = this._language.toJson();
    }
    return data;
  }
}

class BaseUrls {
  String _productImageUrl;
  String _productThumbnailUrl;
  String _brandImageUrl;
  String _customerImageUrl;
  String _bannerImageUrl;
  String _categoryImageUrl;
  String _reviewImageUrl;
  String _sellerImageUrl;
  String _shopImageUrl;
  String _notificationImageUrl;

  BaseUrls({String productImageUrl, String productThumbnailUrl, String brandImageUrl, String customerImageUrl, String bannerImageUrl, String categoryImageUrl, String reviewImageUrl, String sellerImageUrl, String shopImageUrl, String notificationImageUrl}) {
    this._productImageUrl = productImageUrl;
    this._productThumbnailUrl = productThumbnailUrl;
    this._brandImageUrl = brandImageUrl;
    this._customerImageUrl = customerImageUrl;
    this._bannerImageUrl = bannerImageUrl;
    this._categoryImageUrl = categoryImageUrl;
    this._reviewImageUrl = reviewImageUrl;
    this._sellerImageUrl = sellerImageUrl;
    this._shopImageUrl = shopImageUrl;
    this._notificationImageUrl = notificationImageUrl;
  }

  String get productImageUrl => _productImageUrl;
  String get productThumbnailUrl => _productThumbnailUrl;
  String get brandImageUrl => _brandImageUrl;
  String get customerImageUrl => _customerImageUrl;
  String get bannerImageUrl => _bannerImageUrl;
  String get categoryImageUrl => _categoryImageUrl;
  String get reviewImageUrl => _reviewImageUrl;
  String get sellerImageUrl => _sellerImageUrl;
  String get shopImageUrl => _shopImageUrl;
  String get notificationImageUrl => _notificationImageUrl;

  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'];
    _productThumbnailUrl = json['product_thumbnail_url'];
    _brandImageUrl = json['brand_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _categoryImageUrl = json['category_image_url'];
    _reviewImageUrl = json['review_image_url'];
    _sellerImageUrl = json['seller_image_url'];
    _shopImageUrl = json['shop_image_url'];
    _notificationImageUrl = json['notification_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_url'] = this._productImageUrl;
    data['product_thumbnail_url'] = this._productThumbnailUrl;
    data['brand_image_url'] = this._brandImageUrl;
    data['customer_image_url'] = this._customerImageUrl;
    data['banner_image_url'] = this._bannerImageUrl;
    data['category_image_url'] = this._categoryImageUrl;
    data['review_image_url'] = this._reviewImageUrl;
    data['seller_image_url'] = this._sellerImageUrl;
    data['shop_image_url'] = this._shopImageUrl;
    data['notification_image_url'] = this._notificationImageUrl;
    return data;
  }
}

class StaticUrls {
  String _aboutUs;
  String _faq;
  String _termsConditions;
  String _contactUs;
  String _brands;
  String _categories;
  String _customerAccount;

  StaticUrls({String aboutUs, String faq, String termsConditions, String contactUs, String brands, String categories, String customerAccount}) {
    this._aboutUs = aboutUs;
    this._faq = faq;
    this._termsConditions = termsConditions;
    this._contactUs = contactUs;
    this._brands = brands;
    this._categories = categories;
    this._customerAccount = customerAccount;
  }

  String get aboutUs => _aboutUs;
  String get faq => _faq;
  String get termsConditions => _termsConditions;
  String get contactUs => _contactUs;
  String get brands => _brands;
  String get categories => _categories;
  String get customerAccount => _customerAccount;

  StaticUrls.fromJson(Map<String, dynamic> json) {
    _aboutUs = json['about_us'];
    _faq = json['faq'];
    _termsConditions = json['terms_&_conditions'];
    _contactUs = json['contact_us'];
    _brands = json['brands'];
    _categories = json['categories'];
    _customerAccount = json['customer_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about_us'] = this._aboutUs;
    data['faq'] = this._faq;
    data['terms_&_conditions'] = this._termsConditions;
    data['contact_us'] = this._contactUs;
    data['brands'] = this._brands;
    data['categories'] = this._categories;
    data['customer_account'] = this._customerAccount;
    return data;
  }
}

class CurrencyList {
  int _id;
  String _name;
  String _symbol;
  String _code;
  double _exchangeRate;
  int _status;
  String _createdAt;
  String _updatedAt;

  CurrencyList({int id, String name, String symbol, String code, double exchangeRate, int status, String createdAt, String updatedAt}) {
    this._id = id;
    this._name = name;
    this._symbol = symbol;
    this._code = code;
    this._exchangeRate = exchangeRate;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get symbol => _symbol;
  String get code => _code;
  double get exchangeRate => _exchangeRate;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  CurrencyList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _symbol = json['symbol'];
    _code = json['code'];
    _exchangeRate = json['exchange_rate'].toDouble();
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['symbol'] = this._symbol;
    data['code'] = this._code;
    data['exchange_rate'] = this._exchangeRate;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Language {
  LanguageList _languageList;
  Data _data;

  Language({LanguageList list, Data data}) {
    this._languageList = list;
    this._data = data;
  }

  LanguageList get languageList => _languageList;
  Data get data => _data;

  Language.fromJson(Map<String, dynamic> json) {
    _languageList = json['list'] != null ? new LanguageList.fromJson(json['list']) : null;
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._languageList != null) {
      data['list'] = this._languageList.toJson();
    }
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class LanguageList {
  String _bn;
  String _en;

  LanguageList({String bn, String en}) {
    this._bn = bn;
    this._en = en;
  }

  String get bn => _bn;
  String get en => _en;

  LanguageList.fromJson(Map<String, dynamic> json) {
    _bn = json['bn'];
    _en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bn'] = this._bn;
    data['en'] = this._en;
    return data;
  }
}

class Data {
  Bn _bn;
  En _en;

  Data({Bn bn, En en}) {
    this._bn = bn;
    this._en = en;
  }

  Bn get bn => _bn;
  En get en => _en;

  Data.fromJson(Map<String, dynamic> json) {
    _bn = json['bn'] != null ? new Bn.fromJson(json['bn']) : null;
    _en = json['en'] != null ? new En.fromJson(json['en']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._bn != null) {
      data['bn'] = this._bn.toJson();
    }
    if (this._en != null) {
      data['en'] = this._en.toJson();
    }
    return data;
  }
}

class Bn {
  String _home;

  Bn({String home}) {
    this._home = home;
  }

  String get home => _home;

  Bn.fromJson(Map<String, dynamic> json) {
    _home = json['Home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Home'] = this._home;
    return data;
  }
}

class En {
  String _home;
  String _signIn;
  String _myCart;
  String _shippingMethod;
  String _banner;
  String _addMainBanner;
  String _addFooterBanner;
  String _mainBannerForm;
  String _bannerUrl;
  String _bannerType;
  String _published;
  String _mainBannerImage;
  String _footerBannerForm;
  String _footerBannerImage;
  String _bannerTable;
  String _bannerPhoto;
  String _categories;
  String _allCategories;
  String _latestProducts;
  String _moreProducts;
  String _brands;
  String _brandUpdate;
  String _viewAll;
  String _brand;
  String _brandForm;
  String _name;
  String _brandLogo;
  String _brandTable;
  String _sl;
  String _image;
  String _action;
  String _save;
  String _update;
  String _category;
  String _icon;
  String _categoryForm;
  String _categoryTable;
  String _slug;
  String _subCategory;
  String _subCategoryForm;
  String _subCategoryTable;
  String _selectCategoryName;
  String _cashOnDelivery;
  String _sslCommerzPayment;
  String _paypal;
  String _stripe;
  String _paytm;

  En({String home, String signIn, String myCart, String shippingMethod, String banner, String addMainBanner, String addFooterBanner, String mainBannerForm, String bannerUrl, String bannerType, String published, String mainBannerImage, String footerBannerForm, String footerBannerImage, String bannerTable, String bannerPhoto, String categories, String allCategories, String latestProducts, String moreProducts, String brands, String brandUpdate, String viewAll, String brand, String brandForm, String name, String brandLogo, String brandTable, String sl, String image, String action, String save, String update, String category, String icon, String categoryForm, String categoryTable, String slug, String subCategory, String subCategoryForm, String subCategoryTable, String selectCategoryName, String cashOnDelivery, String sslCommerzPayment, String paypal, String stripe, String paytm}) {
    this._home = home;
    this._signIn = signIn;
    this._myCart = myCart;
    this._shippingMethod = shippingMethod;
    this._banner = banner;
    this._addMainBanner = addMainBanner;
    this._addFooterBanner = addFooterBanner;
    this._mainBannerForm = mainBannerForm;
    this._bannerUrl = bannerUrl;
    this._bannerType = bannerType;
    this._published = published;
    this._mainBannerImage = mainBannerImage;
    this._footerBannerForm = footerBannerForm;
    this._footerBannerImage = footerBannerImage;
    this._bannerTable = bannerTable;
    this._bannerPhoto = bannerPhoto;
    this._categories = categories;
    this._allCategories = allCategories;
    this._latestProducts = latestProducts;
    this._moreProducts = moreProducts;
    this._brands = brands;
    this._brandUpdate = brandUpdate;
    this._viewAll = viewAll;
    this._brand = brand;
    this._brandForm = brandForm;
    this._name = name;
    this._brandLogo = brandLogo;
    this._brandTable = brandTable;
    this._sl = sl;
    this._image = image;
    this._action = action;
    this._save = save;
    this._update = update;
    this._category = category;
    this._icon = icon;
    this._categoryForm = categoryForm;
    this._categoryTable = categoryTable;
    this._slug = slug;
    this._subCategory = subCategory;
    this._subCategoryForm = subCategoryForm;
    this._subCategoryTable = subCategoryTable;
    this._selectCategoryName = selectCategoryName;
    this._cashOnDelivery = cashOnDelivery;
    this._sslCommerzPayment = sslCommerzPayment;
    this._paypal = paypal;
    this._stripe = stripe;
    this._paytm = paytm;
  }

  String get home => _home;
  String get signIn => _signIn;
  String get myCart => _myCart;
  String get shippingMethod => _shippingMethod;
  String get banner => _banner;
  String get addMainBanner => _addMainBanner;
  String get addFooterBanner => _addFooterBanner;
  String get mainBannerForm => _mainBannerForm;
  String get bannerUrl => _bannerUrl;
  String get bannerType => _bannerType;
  String get published => _published;
  String get mainBannerImage => _mainBannerImage;
  String get footerBannerForm => _footerBannerForm;
  String get footerBannerImage => _footerBannerImage;
  String get bannerTable => _bannerTable;
  String get bannerPhoto => _bannerPhoto;
  String get categories => _categories;
  String get allCategories => _allCategories;
  String get latestProducts => _latestProducts;
  String get moreProducts => _moreProducts;
  String get brands => _brands;
  String get brandUpdate => _brandUpdate;
  String get viewAll => _viewAll;
  String get brand => _brand;
  String get brandForm => _brandForm;
  String get name => _name;
  String get brandLogo => _brandLogo;
  String get brandTable => _brandTable;
  String get sl => _sl;
  String get image => _image;
  String get action => _action;
  String get save => _save;
  String get update => _update;
  String get category => _category;
  String get icon => _icon;
  String get categoryForm => _categoryForm;
  String get categoryTable => _categoryTable;
  String get slug => _slug;
  String get subCategory => _subCategory;
  String get subCategoryForm => _subCategoryForm;
  String get subCategoryTable => _subCategoryTable;
  String get selectCategoryName => _selectCategoryName;
  String get cashOnDelivery => _cashOnDelivery;
  String get sslCommerzPayment => _sslCommerzPayment;
  String get paypal => _paypal;
  String get stripe => _stripe;
  String get paytm => _paytm;

  En.fromJson(Map<String, dynamic> json) {
    _home = json['Home'];
    _signIn = json['sign_in'];
    _myCart = json['my_cart'];
    _shippingMethod = json['shipping_method'];
    _banner = json['Banner'];
    _addMainBanner = json['add_main_banner'];
    _addFooterBanner = json['add_footer_banner'];
    _mainBannerForm = json['main_banner _form'];
    _bannerUrl = json['banner_url'];
    _bannerType = json['banner_type'];
    _published = json['published'];
    _mainBannerImage = json['main_banner_image'];
    _footerBannerForm = json['footer_banner_form'];
    _footerBannerImage = json['footer_banner_image'];
    _bannerTable = json['banner_table'];
    _bannerPhoto = json['banner_photo'];
    _categories = json['categories'];
    _allCategories = json['all_categories'];
    _latestProducts = json['latest_products'];
    _moreProducts = json['more_products'];
    _brands = json['brands'];
    _brandUpdate = json['brand_update'];
    _viewAll = json['view_all'];
    _brand = json['brand'];
    _brandForm = json['brand_form'];
    _name = json['name'];
    _brandLogo = json['brand_logo'];
    _brandTable = json['brand_table'];
    _sl = json['sl'];
    _image = json['image'];
    _action = json['action'];
    _save = json['save'];
    _update = json['update'];
    _category = json['category'];
    _icon = json['icon'];
    _categoryForm = json['category_form'];
    _categoryTable = json['category_table'];
    _slug = json['slug'];
    _subCategory = json['sub_category'];
    _subCategoryForm = json['sub_category_form'];
    _subCategoryTable = json['sub_category_table'];
    _selectCategoryName = json['select_category_name'];
    _cashOnDelivery = json['cash_on_delivery'];
    _sslCommerzPayment = json['ssl_commerz_payment'];
    _paypal = json['paypal'];
    _stripe = json['stripe'];
    _paytm = json['paytm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Home'] = this._home;
    data['sign_in'] = this._signIn;
    data['my_cart'] = this._myCart;
    data['shipping_method'] = this._shippingMethod;
    data['Banner'] = this._banner;
    data['add_main_banner'] = this._addMainBanner;
    data['add_footer_banner'] = this._addFooterBanner;
    data['main_banner _form'] = this._mainBannerForm;
    data['banner_url'] = this._bannerUrl;
    data['banner_type'] = this._bannerType;
    data['published'] = this._published;
    data['main_banner_image'] = this._mainBannerImage;
    data['footer_banner_form'] = this._footerBannerForm;
    data['footer_banner_image'] = this._footerBannerImage;
    data['banner_table'] = this._bannerTable;
    data['banner_photo'] = this._bannerPhoto;
    data['categories'] = this._categories;
    data['all_categories'] = this._allCategories;
    data['latest_products'] = this._latestProducts;
    data['more_products'] = this._moreProducts;
    data['brands'] = this._brands;
    data['brand_update'] = this._brandUpdate;
    data['view_all'] = this._viewAll;
    data['brand'] = this._brand;
    data['brand_form'] = this._brandForm;
    data['name'] = this._name;
    data['brand_logo'] = this._brandLogo;
    data['brand_table'] = this._brandTable;
    data['sl'] = this._sl;
    data['image'] = this._image;
    data['action'] = this._action;
    data['save'] = this._save;
    data['update'] = this._update;
    data['category'] = this._category;
    data['icon'] = this._icon;
    data['category_form'] = this._categoryForm;
    data['category_table'] = this._categoryTable;
    data['slug'] = this._slug;
    data['sub_category'] = this._subCategory;
    data['sub_category_form'] = this._subCategoryForm;
    data['sub_category_table'] = this._subCategoryTable;
    data['select_category_name'] = this._selectCategoryName;
    data['cash_on_delivery'] = this._cashOnDelivery;
    data['ssl_commerz_payment'] = this._sslCommerzPayment;
    data['paypal'] = this._paypal;
    data['stripe'] = this._stripe;
    data['paytm'] = this._paytm;
    return data;
  }
}
