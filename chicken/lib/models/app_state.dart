import 'package:firebase_auth/firebase_auth.dart';              //new

class AppState {
  final int count;
  final bool isLoading;
  final FirebaseUser currentUser;                               //new

  AppState({
    this.count = 0,
    this.isLoading = false,
    this.currentUser,                                           //new
  });

  AppState copyWith({int count, bool isLoading}) {
    return new AppState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,             // new
    );
  }

  @override
  String toString() {                                           // changed
    return 'AppState{isLoading: $isLoading, count: $count, currentUser: $currentUser}';
  }
}