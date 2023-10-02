import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory/utils/log_utils.dart';

///
/// [AuthService] provides google sign-in capabilities
///
class AuthService {
  late final GoogleSignIn googleSignIn;
  late final FirebaseAuth firebaseAuth;

  AuthService({GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth}) {
    this.googleSignIn = googleSignIn ?? GoogleSignIn();
    this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in
        await firebaseAuth.signInWithCredential(credential);
      }
    } catch (e, st) {
      LogUtils.logError(this, e, st);
      return null;
    }

    return firebaseAuth.currentUser;
  }

  Future<bool> isSignedIn() async {
    return firebaseAuth.currentUser != null;
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e, st) {
      LogUtils.logError(this, e, st);
    }
  }

  Future<bool> signInSilently() async {
    try {
      return await googleSignIn.signInSilently() != null;
    } catch (e, st) {
      LogUtils.logError(this, e, st);
    }
    return false;
  }

  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }
}
