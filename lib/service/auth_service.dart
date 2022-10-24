import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String get userId => _firebaseAuth.currentUser!.uid;

  Stream<User?> get authStateChangesFromFirebase =>
      _firebaseAuth.authStateChanges();

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Registered succesfully';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password added';
      } else if (e.code == 'email-already-in-use') {
        return "This email is already in use";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Signned in successfully';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      } else {
        return e.message.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
