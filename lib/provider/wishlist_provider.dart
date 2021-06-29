import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/wishlist_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/product_details_repo.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/wishlist_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class WishListProvider extends ChangeNotifier {
  final WishListRepo wishListRepo;
  final ProductDetailsRepo productDetailsRepo;
  WishListProvider({@required this.wishListRepo, @required this.productDetailsRepo});

  bool _wish = false;
  String _searchText = "";

  bool get isWish => _wish;
  String get searchText => _searchText;

  clearSearchText() {
    _searchText = '';
    notifyListeners();
  }

  List<Product> _wishList;
  List<Product> _allWishList;

  List<Product> get wishList => _wishList;
  List<Product> get allWishList => _allWishList;

  void searchWishList(String query) async {
    _wishList = [];
    _searchText = query;

    if (query.isNotEmpty) {
      List<Product> products = _allWishList.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      _wishList.addAll(products);
    } else {
      _wishList.addAll(_allWishList);
    }
    notifyListeners();
  }

  void addWishList(int productID, {Function feedbackMessage}) async {
    ApiResponse apiResponse = await wishListRepo.addWishList(productID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String message = map['message'];
      feedbackMessage(message);
      _wish = true;
    } else {
      _wish = false;
      feedbackMessage('${apiResponse.error.toString()}');
      print('${apiResponse.error.toString()}');
    }
    notifyListeners();
  }

  void removeWishList(int productID, {int index, Function feedbackMessage}) async {
    ApiResponse apiResponse = await wishListRepo.removeWishList(productID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String message = map['message'];
      if(feedbackMessage != null) {
        feedbackMessage(message);
      }
      if (index != null) {
        _wishList.removeAt(index);
        _allWishList.removeAt(index);
      }
    } else {
      print('${apiResponse.error.toString()}');
      feedbackMessage('${apiResponse.error.toString()}');
    }
    _wish = false;
    notifyListeners();
  }

  Future<void> initWishList(BuildContext context) async {
    ApiResponse apiResponse = await wishListRepo.getWishList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _wishList = [];
      _allWishList = [];
      notifyListeners();
      apiResponse.response.data.forEach((wishList) async {
        ApiResponse productResponse = await productDetailsRepo.getProduct(WishListModel.fromJson(wishList).productId.toString());
        if (productResponse.response != null && productResponse.response.statusCode == 200) {
          Product _product = Product.fromJson(productResponse.response.data);
          _wishList.add(_product);
          _allWishList.add(_product);
        } else {
          ApiChecker.checkApi(context, productResponse);
        }
        notifyListeners();
      });

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  void checkWishList(String productId, BuildContext context) async {
    ApiResponse apiResponse = await wishListRepo.getWishList();
    List<String> productIdList = [];
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      apiResponse.response.data.forEach((wishList) async {
        WishListModel wishListModel = WishListModel.fromJson(wishList);
        productIdList.add(wishListModel.productId.toString());
      });
      productIdList.contains(productId) ? _wish = true : _wish = false;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
