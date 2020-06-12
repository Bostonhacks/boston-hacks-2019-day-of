import 'package:chicken/models/app_state.dart';
import 'package:chicken/reducers/auth_reducer.dart';
import 'package:chicken/reducers/counter_reducer.dart';

AppState appReducer(state, action) {
  return new AppState(
    isLoading: false,
    count: counterReducer(state.count, action),
    currentUser: authReducer(state.currentUser, action),
  ); //new
}
