class ResponseDataClass {
  String message;
  int code;
  List result;
  Map queryParam;

  ResponseDataClass({this.message, this.code, this.result,this.queryParam});

  factory ResponseDataClass.fromJson(Map<String, dynamic> json) {
    return ResponseDataClass(
      message: json['message'],
      code: json['code'],
      result: json['result'],
        queryParam : json['queryParam']
    );
  }
}