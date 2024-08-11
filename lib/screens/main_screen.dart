import 'package:dio/dio.dart';
import 'package:fin_wealth/blocs/strategy/strategy_bloc.dart';
import 'package:fin_wealth/blocs/strategy/strategy_event.dart';
import 'package:fin_wealth/blocs/strategy/strategy_state.dart';
import 'package:fin_wealth/respositories/strategy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Market Strategies'),
          ),
      body: BlocProvider(
        create: (context) => StrategyBloc(
          strategyRepository: StrategyRepository(dio: Dio()),
        )..add(FetchStockStrategies()),
        child: BlocBuilder<StrategyBloc, StrategyState>(
          builder: (context, state) {
            if (state is StrategyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StrategyLoaded) {
              return ListView.builder(
                itemCount: state.stockStrategies.length,
                itemBuilder: (context, index) {
                  final strategy = state.stockStrategies[index];
                  return ExpansionTile(
                    title: Text(strategy.strategy),
                    children: strategy.stockList.map((stock) {
                      return ListTile(
                        title: Text(stock.ticker),
                        subtitle: Text(
                          stock.takeProfitPrice != null
                              ? 'Take Profit: ${stock.takeProfitPrice}'
                              : stock.predictedPrice != null
                                  ? 'Predicted Price: ${stock.predictedPrice}'
                                  : '',
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            } else if (state is StrategyFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
