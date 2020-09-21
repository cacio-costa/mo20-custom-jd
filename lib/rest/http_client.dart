import 'dart:convert';

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
    data.body = utf8.decode(data.body.codeUnits);

    debugPrint('Response: ${data.statusCode}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');

    return data;
  }
}

/**
 * ATENÇÃO: TROQUE PELO IP DA SUA MÁQUINA!
 */
const String baseUrl = 'http://192.168.0.14:8080/api';

HttpClientWithInterceptor httpClient = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);
