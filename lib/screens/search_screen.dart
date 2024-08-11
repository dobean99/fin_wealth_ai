import 'package:fin_wealth/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nhập mã chứng khoán',
                labelStyle: const TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    _searchStocks(context, _searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onSubmitted: (query) {
                _searchStocks(context, query);
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    final stock = state.stock;

                    return ListView(
                      children: [
                        ListTile(
                          title: Text(
                            _searchController.text.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Giá: ${CurrencyFormatter.format(stock.marketPrice)}\n'
                            '${stock.reports}\n\n'
                            'Dự đoán giá: ${CurrencyFormatter.format(stock.averageTargetPrice)}',
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchFailure) {
                    return const Center(
                        child: Text('Vui lòng nhập đúng mã chứng khoán!'));
                  }
                  return const Center(child: Text('Hãy nhập mã chứng khóan!'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchStocks(BuildContext context, String query) {
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(SearchStocks(query: query));
    }
  }
}
