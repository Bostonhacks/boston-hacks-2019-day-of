import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chicken/middleware/auth_middleware.dart';
import 'package:chicken/reducers/app_reducer.dart';
import 'package:chicken/routes.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'models/app_state.dart';

void main() {
  var store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    distinct: true,
    middleware: []
      ..addAll(createAuthMiddleware())
      ..add(new LoggingMiddleware.printer()), //new
  );
  runApp(new MainApp(
    store: store
  ));
}

class MainApp extends StatelessWidget {
  final String title = 'MeSuite';
  final Store<AppState> store;

  MainApp({this.store});

  @override
  Widget build(BuildContext context) {
    // var store = new Store<AppState>(
    //   appReducer,
    //   initialState: new AppState(),
    //   distinct: true,
    //   middleware: []
    //     ..addAll(createAuthMiddleware())
    //     ..add(new LoggingMiddleware.printer()), //new
    // );

    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        routes: getRoutes(context, store),
        initialRoute: '/login',
      ),
    );
  }
}
