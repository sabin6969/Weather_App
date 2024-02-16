abstract class AppException implements Exception {
  String message;
  AppException({required this.message});
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({String? message})
      : super(message: message ?? "Unauthorized request");
}

class ServerRequestTimeoutException extends AppException {
  ServerRequestTimeoutException({String? message})
      : super(message: message ?? "Server request time out");
}

class InternalServerException extends AppException {
  InternalServerException({String? message})
      : super(
          message: message ?? " Internal Server error",
        );
}

class NotFoundException extends AppException {
  NotFoundException({String? message})
      : super(message: "Requested city not found");
}
