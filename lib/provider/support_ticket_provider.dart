import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/support_ticket_repo.dart';

class SupportTicketProvider extends ChangeNotifier {
  final SupportTicketRepo supportTicketRepo;
  SupportTicketProvider({@required this.supportTicketRepo});

  List<SupportTicketModel> _supportTicketList;
  bool _isLoading = false;

  List<SupportTicketModel> get supportTicketList => _supportTicketList;
  bool get isLoading => _isLoading;

  void sendSupportTicket(SupportTicketBody supportTicketBody, Function(bool isSuccess, String message) callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await supportTicketRepo.sendSupportTicket(supportTicketBody);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      String message = apiResponse.response.data["message"];
      callback(true, message);
      _isLoading = false;
      _supportTicketList.add(SupportTicketModel(description: supportTicketBody.description, type: supportTicketBody.type,
          subject: supportTicketBody.subject, createdAt: DateConverter.formatDate(DateTime.now()), status: 0));
      notifyListeners();
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
      callback(false, errorMessage);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSupportTicketList(BuildContext context) async {
    if(supportTicketList == null) {
      ApiResponse apiResponse = await supportTicketRepo.getSupportTicketList();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _supportTicketList = [];
        apiResponse.response.data.forEach((supportTicket) => _supportTicketList.add(SupportTicketModel.fromJson(supportTicket)));
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }
}
