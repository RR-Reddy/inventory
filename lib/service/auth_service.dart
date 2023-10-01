import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in
      await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return FirebaseAuth.instance.currentUser;
  }

  Future<bool> isSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }

  Future<void> signInSilently() async {
    await googleSignIn.signInSilently();
  }

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
