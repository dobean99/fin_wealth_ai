import 'package:dio/dio.dart';
import 'package:fin_wealth/models/market_report.dart';

class MarketRepository {
  final Dio dio;

  final String _baseUrl =
      'https://finwealth.vn/api/market-reports/?keys=vnindex';

  MarketRepository({required this.dio});

  Future<List<MarketReport>> fetchMarketReports() async {
    try {
      final response = await dio.get(_baseUrl);
      if (response.headers
              .value('content-type')
              ?.contains('application/json') ==
          true) {
        if (response.statusCode == 200) {
          final List<dynamic> jsonList = response.data;
          return jsonList.map((json) => MarketReport.fromJson(json)).toList();
        } else {
          throw Exception(
              'Failed to load market reports: ${response.statusCode}');
        }
      } else {
        throw Exception(
            'Unexpected response format: ${response.headers.value('content-type')}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Failed to load market reports: ${e.response!.data}');
      } else {
        throw Exception('Failed to load market reports: ${e.message}');
      }
    }
  }
}
