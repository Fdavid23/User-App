import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Se canceló la solicitud al servidor API";
              break;
            case DioErrorType.connectTimeout:
              errorDescription = "Tiempo de espera de conexión con el servidor API";
              break;
            case DioErrorType.other:
              errorDescription =
              "La conexión al servidor API falló debido a la conexión a Internet";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
              "Tiempo de espera de recepción en conexión con el servidor API";
              break;
            case DioErrorType.response:
              switch (error.response.statusCode) {
                case 404:
                case 500:
                case 503:
                  errorDescription = error.response.statusMessage;
                  break;
                default:
                  ErrorResponse errorResponse =
                  ErrorResponse.fromJson(error.response.data);
                  if (errorResponse.errors != null &&
                      errorResponse.errors.length > 0)
                    errorDescription = errorResponse;
                  else
                    errorDescription =
                    "Error al cargar datos - código de estado: ${error.response.statusCode}";
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Enviar tiempo de espera con el servidor";
              break;
          }
        } else {
          errorDescription = "Ocurrió un error inesperado";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "no es un subtipo de excepción";
    }
    return errorDescription;
  }
}
