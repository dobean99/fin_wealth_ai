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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Search Stock'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter stock symbol',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    _searchStocks(context, _searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSubmitted: (query) {
                _searchStocks(context, query);
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    final stock = state.stock;
                    return ListView(
                      children: [
                        ListTile(
                          title: Text(stock.id),
                          subtitle: Text(
                            'Price: \$${stock.marketPrice.toStringAsFixed(2)}\n'
                            'Report: ${stock.reports}\n'
                            'Prediction: \$${stock.averageTargetPrice.toStringAsFixed(2)}',
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return const Center(
                      child: Text('Enter a stock symbol to search.'));
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
