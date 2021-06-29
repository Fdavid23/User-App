import 'package:flutter/cupertino.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/shipping_method_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/order_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo orderRepo;
  OrderProvider({@required this.orderRepo});

  List<OrderModel> _pendingList;
  List<OrderModel> _deliveredList;
  List<OrderModel> _canceledList;
  int _addressIndex;
  int _shippingIndex;
  bool _isLoading = false;
  List<ShippingMethodModel> _shippingList;
  int _paymentMethodIndex = 0;

  List<OrderModel> get pendingList => _pendingList != null ? _pendingList.reversed.toList() : _pendingList;
  List<OrderModel> get deliveredList => _deliveredList != null ? _deliveredList.reversed.toList() : _deliveredList;
  List<OrderModel> get canceledList => _canceledList != null ? _canceledList.reversed.toList() : _canceledList;
  int get addressIndex => _addressIndex;
  int get shippingIndex => _shippingIndex;
  bool get isLoading => _isLoading;
  List<ShippingMethodModel> get shippingList => _shippingList;
  int get paymentMethodIndex => _paymentMethodIndex;

  Future<void> initOrderList(BuildContext context) async {
    ApiResponse apiResponse = await orderRepo.getOrderList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _pendingList = [];
      _deliveredList = [];
      _canceledList = [];
      apiResponse.response.data.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == AppConstants.PENDING || orderModel.orderStatus == AppConstants.CONFIRMED
            || orderModel.orderStatus == AppConstants.PROCESSING || orderModel.orderStatus == AppConstants.PROCESSED) {
          _pendingList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.DELIVERED) {
          _deliveredList.add(orderModel);
        } else if (orderModel.orderStatus == AppConstants.CANCELLED || orderModel.orderStatus == AppConstants.FAILED
            || orderModel.orderStatus == AppConstants.RETURNED) {
          _canceledList.add(orderModel);
        }
      });
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  List<OrderDetailsModel> _orderDetails;
  List<OrderDetailsModel> get orderDetails => _orderDetails;

  void getOrderDetails(String orderID, BuildContext context) async {
    _orderDetails = null;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.getOrderDetails(orderID);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _orderDetails = [];
      apiResponse.response.data.forEach((order) => _orderDetails.add(OrderDetailsModel.fromJson(order)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> placeOrder(OrderPlaceModel orderPlaceModel, Function callback, List<CartModel> cartList) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await orderRepo.placeOrder(orderPlaceModel.toJson());
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _addressIndex = null;
      String message = apiResponse.response.data['message'];
      String orderID = apiResponse.response.data['order_id'].toString();
      callback(true, message, orderID, cartList);
      print('-------- Order placed successfully $orderID ----------');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage, '-1', cartList);
    }
    notifyListeners();
  }

  void stopLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    notifyListeners();
  }

  Future<void> initShippingList(BuildContext context) async {
    _shippingIndex = null;
    _addressIndex = null;
    ApiResponse apiResponse = await orderRepo.getShippingList();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _shippingList = [];
      apiResponse.response.data.forEach((shippingMethod) => _shippingList.add(ShippingMethodModel.fromJson(shippingMethod)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void setSelectedShippingAddress(int index) {
    _shippingIndex = index;
    notifyListeners();
  }

  OrderModel _trackingModel;
  OrderModel get trackingModel => _trackingModel;

  Future<void> initTrackingInfo(String orderID, OrderModel orderModel, bool fromDetails, BuildContext context) async {
    if(fromDetails) {
      _orderDetails = null;
    }
    if(orderModel == null) {
      _trackingModel = null;
      notifyListeners();
      ApiResponse apiResponse = await orderRepo.getTrackingInfo(orderID);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _trackingModel = OrderModel.fromJson(apiResponse.response.data);
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }else {
      _trackingModel = orderModel;
    }
  }

  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    notifyListeners();
  }

}
