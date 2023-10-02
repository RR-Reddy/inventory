import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory/service/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([
  GoogleSignIn,
  FirebaseAuth,
  User,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  UserCredential
])
void main() async {


  group('AuthService +ve cases', () {

    final mockGoogleSignIn = MockGoogleSignIn();
    final mockFirebaseAuth = MockFirebaseAuth();
    final mockUser = MockUser();
    final mockGoogleSignInAccount = MockGoogleSignInAccount();
    final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    final mockUserCredential = MockUserCredential();

    final authService = AuthService(
      googleSignIn: mockGoogleSignIn,
      firebaseAuth: mockFirebaseAuth,
    );

    when(mockGoogleSignIn.signInSilently())
        .thenAnswer((_) async => mockGoogleSignInAccount);

    test('Should be signInSilently', () async {
      expect((await authService.signInSilently()), true);
    });

    when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);

    test('Should be signedIn', () async {
      expect((await authService.isSignedIn()), true);
    });

    when(mockFirebaseAuth.signOut()).thenAnswer((_) => Future.value());
    when(mockGoogleSignIn.signOut()).thenAnswer((_) => Future.value());

    test('Should be signOut', () async {
      expect( authService.signOut(), isA<Future<void>>());
    });

    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) => Future.value(mockGoogleSignInAccount));
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) => Future.value(mockGoogleSignInAuthentication));
    when(mockGoogleSignInAuthentication.accessToken)
        .thenAnswer((_) => 'accessToken');
    when(mockGoogleSignInAuthentication.idToken).thenAnswer((_) => 'idToken');
    when(mockFirebaseAuth.signInWithCredential(any))
        .thenAnswer((_) => Future.value(mockUserCredential));
    when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);

    test('Should be sign-in', () async {
      expect((await authService.signInWithGoogle()), mockUser);
    });

    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => Stream.value(mockUser));

    test('Should be emit stream', () async {
      expect(await (authService.authStateChanges().first), mockUser);
    });
  });


  group('AuthService -ve cases', () {

    final mockGoogleSignIn = MockGoogleSignIn();
    final mockFirebaseAuth = MockFirebaseAuth();

    final authService = AuthService(
      googleSignIn: mockGoogleSignIn,
      firebaseAuth: mockFirebaseAuth,
    );

    when(mockGoogleSignIn.signInSilently())
        .thenThrow(Exception());
    test('Should not be signInSilently', () async {
      expect((await authService.signInSilently()), false);
    });

    when(mockFirebaseAuth.currentUser).thenAnswer((_) => null);

    test('Should not be signedIn', () async {
      expect((await authService.isSignedIn()), false);
    });

    when(mockFirebaseAuth.signOut()).thenThrow(Exception());

    test('Should be throwsException', () async {
      expect(authService.signOut(), isA<Future<void>>());
    });

    when(mockGoogleSignIn.signIn()).thenThrow(Exception());

    test('Should not be sign-in', () async {
      expect((await authService.signInWithGoogle()), null);
    });
  });
}
