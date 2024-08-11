import 'package:dio/dio.dart';
import 'package:fin_wealth/models/stock_strategy.dart';

class StrategyRepository {
  final Dio dio;

  StrategyRepository({required this.dio});

  Future<List<StockStrategy>> fetchStockStrategies() async {
    try {
      final response =
          await dio.get('https://finwealth.vn/api/latest-signals/');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        return jsonResponse
            .map((json) => StockStrategy.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load stock strategies');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load stock strategies: ${e.message}');
    }
  }
}
