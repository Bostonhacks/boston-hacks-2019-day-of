import 'package:chicken/models/app_state.dart';
import 'package:chicken/reducers/auth_reducer.dart';

AppState appReducer(state, action) {
  return new AppState(
    isLoading: false,
    currentUser: authReducer(state.currentUser, action),
  ); //new
}