class MainModel {
  MainModel({
    required this.status,
    required this.message,
    required this.key,
    required this.data,
  });

  int status;
  String message, key;
  dynamic data;

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        status: json["status"] ?? 0,
        message: json["message"].toString(),
        key: json["key"].toString(),
        data: json["data"],
      );
}
