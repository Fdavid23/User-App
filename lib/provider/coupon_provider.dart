import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/coupon_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/coupon_repo.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo couponRepo;
  CouponProvider({@required this.couponRepo});

  CouponModel _coupon;
  double _discount;
  bool _isLoading = false;
  CouponModel get coupon => _coupon;
  double get discount => _discount;
  bool get isLoading => _isLoading;

  Future<double> initCoupon(String coupon, double order) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await couponRepo.getCoupon(coupon);
    if (apiResponse.response != null && apiResponse.response.toString() != '{}' && apiResponse.response.statusCode == 200) {
      _coupon = CouponModel.fromJson(apiResponse.response.data);
      if (_coupon.minPurchase != null && _coupon.minPurchase < order) {
        if(_coupon.discountType == 'percent') {
          _discount = (_coupon.discount * order / 100) < _coupon.maxDiscount
              ? (_coupon.discount * order / 100) : _coupon.maxDiscount;
        }else {
          _discount = _coupon.discount;
        }
      } else {
        _discount = 0;
      }
    } else {
      print(apiResponse.error.toString());
      _discount = 0;
    }
    _isLoading = false;
    notifyListeners();
    return _discount;
  }

  void removePrevCouponData() {
    _coupon = null;
    _isLoading = false;
    _discount = null;
  }
}
