import 'package:equatable/equatable.dart';

class StockStrategy extends Equatable {
  final String strategy;
  final List<Stock> stockList;

  const StockStrategy({required this.strategy, required this.stockList});

  factory StockStrategy.fromJson(Map<String, dynamic> json) {
    var list = json['stock_list'] as List;
    List<Stock> stockList = list.map((i) => Stock.fromJson(i)).toList();

    return StockStrategy(
      strategy: json['strategy'],
      stockList: stockList,
    );
  }

  @override
  List<Object?> get props => [strategy, stockList];
}

class Stock extends Equatable {
  final String ticker;
  final double? takeProfitPrice;
  final double? predictedPrice;
  final double? r2;
  final double? mse;
  final double? priceChange;

  Stock({
    required this.ticker,
    this.takeProfitPrice,
    this.predictedPrice,
    this.r2,
    this.mse,
    this.priceChange,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      ticker: json['ticker'] ?? json['symbol'],
      takeProfitPrice: json['take_profit_price']?.toDouble(),
      predictedPrice: json['predicted_price']?.toDouble(),
      r2: json['r2']?.toDouble(),
      mse: json['mse']?.toDouble(),
      priceChange: json['price_change']?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        ticker,
        takeProfitPrice,
        predictedPrice,
        r2,
        mse,
        priceChange,
      ];
}
