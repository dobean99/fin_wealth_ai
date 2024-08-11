import 'package:dio/dio.dart';
import 'package:fin_wealth/blocs/market/market_bloc.dart';
import 'package:fin_wealth/blocs/search/search_bloc.dart';
import 'package:fin_wealth/respositories/auth_repository.dart';
import 'package:fin_wealth/respositories/market_repository.dart';
import 'package:fin_wealth/respositories/stock_repository.dart';
import 'package:fin_wealth/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: AuthRepository(dio: dio)),
        ),
        BlocProvider(
          create: (context) =>
              SearchBloc(stockRepository: StockRepository(dio: dio)),
        ),
        BlocProvider(
          create: (context) =>
              MarketBloc(marketRepository: MarketRepository(dio: dio)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
