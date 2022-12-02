class ErrorModel {
  final String statusMessage;

  ErrorModel({required this.statusMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(statusMessage: json['status_message']);
}
