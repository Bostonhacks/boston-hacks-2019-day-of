
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chicken/actions/auth_actions.dart';
import 'package:chicken/models/app_state.dart';
import 'package:redux/redux.dart';

String name;
String email;
String imageUrl;

List<Middleware<AppState>> createAuthMiddleware() {
  final logIn = _createLogInMiddleware();
  final logOut = _createLogOutMiddleware();
  return [
    new TypedMiddleware<AppState, LogIn>(logIn),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ];
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    if (action is LogIn) {
      try {
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        user = (await _auth.signInWithCredential(credential)).user;
        
        print('Logged in ${user.displayName}');
        store.dispatch(new LogInSuccessful(user: user));
        name = user.displayName;
        email = user.email;
        imageUrl = user.photoUrl;
      } catch (error) {
        store.dispatch(new LogInFail(error));
      }
    }
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (action is LogOut) {
      try {
        await _auth.signOut();
        print('logging out...');
        store.dispatch(new LogOutSuccessful());
      } catch (error) {
        store.dispatch(new LogOutFail(error));
      }
    }
  };
}