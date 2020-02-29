abstract class MyAppError extends Error {
  String message();
}

class NetWorkError extends MyAppError {
  @override
  String message() {
    return "Something Went Wrong !!";
  }
}
