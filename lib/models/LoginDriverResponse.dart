import 'DeliveryAgent.dart';

class LoginDriverResponse {
  final String message;
  final bool userfound;
  final bool passwordIsValid;
  final DeliveryAgent agent;

  LoginDriverResponse({
    required this.message,
    required this.userfound,
    required this.passwordIsValid,
    required this.agent,
  });

  factory LoginDriverResponse.fromJson(Map<String, dynamic> json) {
    return LoginDriverResponse(
      message: json['message'] as String,
      userfound: json['userfound'] as bool,
      passwordIsValid: json['passwordIsValid'] as bool,
      agent: DeliveryAgent.fromJson(json['agent'] as Map<String, dynamic>),
    );
  }
}


