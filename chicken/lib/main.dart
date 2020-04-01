import 'package:chicken/pages/auth_page.dart';
import 'package:chicken/middleware/auth_middleware.dart';
import 'package:chicken/models/app_state.dart';
import 'package:chicken/reducers/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';                              // new
import 'package:flutter_redux/flutter_redux.dart';  
import 'package:redux_logging/redux_logging.dart';   

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  // @override

  

  Widget build(BuildContext context) {
    // Wrap your MaterialApp in a StoreProvider
    final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    // Middleware has to be a List of MiddleWare functions
    // This syntax will allow you to add any middleware
    // regardless of wether it's already a list of middleware
    // or it's just a function:
    middleware: []
      ..addAll(createAuthMiddleware(context))
      ..add(new LoggingMiddleware.printer()),
  );
    return new StoreProvider(                                   // new
      store: store,                                             // new
      child: new MaterialApp(
          home: new AuthPage(),
      ),
    );
  }
}