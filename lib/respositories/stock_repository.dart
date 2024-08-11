import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fin_wealth/models/stock_models.dart';

class StockRepository {
  final Dio dio;

  final String _baseUrl =
      'https://finwealth.vn/api/stock-reports'; // Replace with your actual base URL

  StockRepository({required this.dio}) {
    // Optional: Set up logging for debugging
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
  }

  Future<Stock> searchStocks(String stockSymbol) async {
    try {
      final response = await dio.get(
        _baseUrl,
        queryParameters: {'stock': stockSymbol},
      );

      // Check if the response is JSON
      if (response.headers
              .value('content-type')
              ?.contains('application/json') ==
          true) {
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonMap = response.data is String
              ? json.decode(response.data)
              : response.data;

          // Assuming the response is a single Stock object
          final stock = Stock.fromJson(jsonMap);

          return stock;
        } else {
          throw Exception('Failed to load stocks: ${response.statusCode}');
        }
      } else {
        throw Exception(
            'Unexpected response format: ${response.headers.value('content-type')}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle error responses with more details
        throw Exception('Failed to load stocks: ${e.response!.data}');
      } else {
        // Handle cases where there's no response
        throw Exception('Failed to load stocks: ${e.message}');
      }
    }
  }
}
