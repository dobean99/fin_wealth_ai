import 'package:dio/dio.dart';
import 'package:fin_wealth/respositories/market_repository.dart';
import 'package:fin_wealth/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/market/market_bloc.dart';
import '../blocs/market/market_event.dart';
import '../blocs/market/market_state.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo Cáo Thị Trường'),
      ),
      body: BlocProvider(
        create: (context) => MarketBloc(
          marketRepository: MarketRepository(dio: Dio()),
        )..add(FetchMarketReports()), // Fetch reports when screen is built
        child: BlocBuilder<MarketBloc, MarketState>(
          builder: (context, state) {
            if (state is MarketLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MarketLoaded) {
              if (state.reports.isEmpty) {
                return const Center(child: Text('No reports available.'));
              }
              return ListView.builder(
                itemCount: state.reports.length,
                itemBuilder: (context, index) {
                  final report = state.reports[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        'Ngày: ${DateFormatter.formatDateFromString(report.date)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(report.content),
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                  );
                },
              );
            } else if (state is MarketFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }
}
