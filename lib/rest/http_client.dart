import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint('Request: ${data.method} ${data.url}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    debugPrint('Params: ${data.params}');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint('Response: ${data.statusCode}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');

    return data;
  }
}

HttpClientWithInterceptor httpClient = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
