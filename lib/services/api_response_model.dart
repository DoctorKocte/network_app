class ApiResponse {
  bool success;
  Map<String, dynamic>? data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.parseBody(Map<String, dynamic> data) {
    return ApiResponse(
      success: data['success'],
      data: data['data'],
      message: data['message']
    );
  }
}