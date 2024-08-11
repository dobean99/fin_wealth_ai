import 'package:dio/dio.dart';
import 'package:fin_wealth/blocs/strategy/strategy_bloc.dart';
import 'package:fin_wealth/blocs/strategy/strategy_event.dart';
import 'package:fin_wealth/blocs/strategy/strategy_state.dart';
import 'package:fin_wealth/respositories/strategy_repository.dart';
import 'package:fin_wealth/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StrategyBloc(
        strategyRepository: StrategyRepository(dio: Dio()),
      )..add(FetchStockStrategies()),
      child: BlocBuilder<StrategyBloc, StrategyState>(
        builder: (context, state) {
          if (state is StrategyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StrategyLoaded) {
            return DefaultTabController(
              length: state.stockStrategies.length, // Number of tabs is dynamic
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Chiến Lược Đầu Tư'),
                  bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable:
                        true, // Make the tabs scrollable if there are many
                    tabs: state.stockStrategies.map((strategy) {
                      return Tab(
                        child: Text(
                          strategy.strategy,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                ),
                body: TabBarView(
                  children: state.stockStrategies.map((strategy) {
                    return ListView.builder(
                      itemCount: strategy.stockList.length,
                      itemBuilder: (context, index) {
                        final stock = strategy.stockList[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    Colors.grey[300]!, // Change color as needed
                                width: 1.0,
                                // Adjust width as needed
                              ),
                            ),
                          ),
                          child: ListTile(
                            leading: Text(
                              stock.ticker,
                              style: const TextStyle(
                                fontSize:
                                    14, // Adjust font size for the trailing text
                                fontWeight: FontWeight
                                    .bold, // Optionally, make the text bold
                              ),
                            ),
                            trailing: Text(
                              stock.takeProfitPrice != null
                                  ? 'Chốt lời: ${CurrencyFormatter.formatThousanDong(stock.takeProfitPrice ?? 0)}'
                                  : stock.predictedPrice != null
                                      ? 'Dự đoán: ${CurrencyFormatter.formatThousanDong(stock.predictedPrice ?? 0)}'
                                      : '',
                              style: const TextStyle(
                                fontSize:
                                    14, // Adjust font size for the trailing text
                                fontWeight: FontWeight
                                    .bold, // Optionally, make the text bold
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          } else if (state is StrategyFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
