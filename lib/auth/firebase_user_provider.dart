import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RobindoFirebaseUser {
  RobindoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

RobindoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RobindoFirebaseUser> robindoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<RobindoFirebaseUser>(
        (user) => currentUser = RobindoFirebaseUser(user));
