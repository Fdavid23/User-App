import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/cart_repo.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});

  List<CartModel> _cartList = [];
  List<bool> _isSelectedList = [];
  double _amount = 0.0;
  bool _isSelectAll = true;

  List<CartModel> get cartList => _cartList;
  List<bool> get isSelectedList => _isSelectedList;
  double get amount => _amount;
  bool get isAllSelect => _isSelectAll;

  void getCartData() {
    _cartList.clear();
    _isSelectedList.clear();
    _isSelectAll = true;
    _cartList.addAll(cartRepo.getCartList());
    _cartList.forEach((cart) {
      _isSelectedList.add(true);
      _amount = _amount + (cart.discountedPrice * cart.quantity);
    });
  }

  void setQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _isSelectedList[index] ? _amount = _amount + _cartList[index].discountedPrice : _amount = _amount;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _isSelectedList[index] ? _amount = _amount - _cartList[index].discountedPrice : _amount = _amount;
    }
    cartRepo.addToCartList(_cartList);

    notifyListeners();
  }

  void toggleSelected(int index) {
    _isSelectedList[index] = !_isSelectedList[index];

    _amount = 0.0;
    for (int i = 0; i < _isSelectedList.length; i++) {
      if (_isSelectedList[i]) {
        _amount = _amount + (_cartList[i].discountedPrice * _cartList[index].quantity);
      }
    }

    _isSelectedList.forEach((isSelect) => isSelect ? null : _isSelectAll = false);

    notifyListeners();
  }

  void toggleAllSelect() {
    _isSelectAll = !_isSelectAll;

    if (_isSelectAll) {
      _amount = 0.0;
      for (int i = 0; i < _isSelectedList.length; i++) {
        _isSelectedList[i] = true;
        _amount = _amount + (_cartList[i].discountedPrice * _cartList[i].quantity);
      }
    } else {
      _amount = 0.0;
      for (int i = 0; i < _isSelectedList.length; i++) {
        _isSelectedList[i] = false;
      }
    }

    notifyListeners();
  }

  void addToCart(CartModel cartModel) {
    _cartList.add(cartModel);
    _isSelectedList.add(true);
    cartRepo.addToCartList(_cartList);
    _amount = _amount + (cartModel.discountedPrice * cartModel.quantity);
    notifyListeners();
  }

  void removeFromCart(int index) {
    if(_isSelectedList[index]) {
      _amount = _amount - (_cartList[index].discountedPrice * _cartList[index].quantity);
    }
    _cartList.removeAt(index);
    _isSelectedList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  bool isAddedInCart(int id) {
    List<int> idList = [];
    _cartList.forEach((cartModel) => idList.add(cartModel.id));
    return idList.contains(id);
  }

  void removeCheckoutProduct(List<CartModel> carts) {
    carts.forEach((cart) {
      _amount = _amount - (cart.discountedPrice * cart.quantity);
      _cartList.removeWhere((cartModel) => cartModel.id == cart.id);
      _isSelectedList.removeWhere((selected) => selected);
    });
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }
}
