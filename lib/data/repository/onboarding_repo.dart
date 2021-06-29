import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/onboarding_model.dart';

class OnBoardingRepo {
  final DioClient dioClient;
  OnBoardingRepo({@required this.dioClient});

  Future<ApiResponse> getOnBoardingList() async {
    try {
      List<OnboardingModel> onBoardingList = [
        OnboardingModel(
            'assets/images/onboarding_image_one.png',
            'Bienvenido a Garage_Republik',
            'Aquí comprar es fácil y divertido con 50 mil productos, promociones exclusivas, ofertas y promociones.'),
        OnboardingModel(
            'assets/images/onboarding_image_two.png',
            'Pago fácil y seguro',
            'Disfrute de pagos más seguros y rápidos. Ofrecemos pasarelas de pago de fama mundial para un pago suave y seguro de su compra.'),
        OnboardingModel(
            'assets/images/onboarding_image_three.png',
            'Entrega más rápida',
            'La empresa están esperando su pedido, realizar un pedido, obtener una entrega rápida y disfrutar de su vida diaria.'),
      ];

      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: onBoardingList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
