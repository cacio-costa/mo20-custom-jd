import 'dart:convert';

import 'package:casadocodigoapp/dto/dashboard_input_dto.dart';
import 'package:casadocodigoapp/models/author.dart';
import 'package:casadocodigoapp/rest/http_client.dart';
import 'package:http/http.dart';

class DashboardRestClient {
  static const String _dashboardResourceUrl = baseUrl + '/admin/dashboard';

  Future<DashboardInputDto> getDashboardStatistics() async {
    Response response = await httpClient.get(_dashboardResourceUrl).timeout(Duration(seconds: 15));

    Map<String, dynamic> dashboardJson = jsonDecode(response.body);
    return DashboardInputDto.fromJson(dashboardJson);
  }

}
