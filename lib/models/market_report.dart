import 'package:equatable/equatable.dart';

class MarketReport extends Equatable {
  final String content;
  final String date;

  const MarketReport({required this.content, required this.date});

  factory MarketReport.fromJson(Map<String, dynamic> json) {
    return MarketReport(
      content: json['content'],
      date: json['date'],
    );
  }

  @override
  List<Object> get props => [content, date];
}
