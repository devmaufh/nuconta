import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Utilities/Constants.dart';
import 'bloc/customer/customer_bloc.dart';

import 'package:nuconta_marketplace/pages/home_page.dart';

import 'repositories/graphql_repository.dart';
import 'services/graphql/graphql_service.dart';

void main() {
  GraphqlRepository repository = GraphqlRepository(GraphqlService());
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final GraphqlRepository repository;
  const MyApp({Key key, @required this.repository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Constants.primaryPurple));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => new CustomerBloc(repository),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Catamaran', accentColor: Constants.primaryPurple),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
        },
      ),
    );
  }
}
