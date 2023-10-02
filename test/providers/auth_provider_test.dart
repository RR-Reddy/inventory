import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory/providers/auth_provider.dart';
import 'package:inventory/service/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_provider_test.mocks.dart';

@GenerateMocks([
  NavService,
  AuthService,
  User,
  NavigatorState,
])
void main() async {
  group('AuthProvider +ve cases', () {
    final mockNavService = MockNavService();
    final mockAuthService = MockAuthService();
    final mockUser = MockUser();

    when(mockAuthService.signInWithGoogle()).thenAnswer((_) async => mockUser);
    when(mockAuthService.authStateChanges())
        .thenAnswer((_) => Stream.value(mockUser));

    final authProvider = AuthProvider(
      navService: mockNavService,
      authService: mockAuthService,
    );
    test('Should return without any errors', () async {
      expect(authProvider.startSignFlow(), isA<Future<void>>());
    });

    when(mockAuthService.signInSilently()).thenAnswer((_) async => true);
    test('Should return without any errors', () async {
      expect(authProvider.signInSilently(), isA<Future<void>>());
    });

    when(mockAuthService.signOut()).thenAnswer((_) async => Future.value());
    test('Should return without any errors', () async {
      expect(authProvider.signOut(), isA<Future<void>>());
    });

    test('Should Sign-in success', () async {
      expect(authProvider.isSignedIn, true);
    });

    test('Should have user info', () async {
      expect(authProvider.user, mockUser);
    });


  });

  group('AuthProvider -ve cases', () {
    final mockNavService = MockNavService();
    final mockAuthService = MockAuthService();
    final mockUser = MockUser();
    final mockNavigatorState = MockNavigatorState();

    when(mockAuthService.signInWithGoogle()).thenAnswer((_) async => mockUser);
    when(mockAuthService.authStateChanges())
        .thenAnswer((_) => Stream.value(null));

    when(mockNavService.nav).thenAnswer((_) => mockNavigatorState);
    when(mockNavigatorState.pushNamedAndRemoveUntil(any, any))
        .thenAnswer((_) => Future.value());

    final authProvider = AuthProvider(
      navService: mockNavService,
      authService: mockAuthService,
    );

    test('Should not Sign-in  ', () async {
      expect(authProvider.isSignedIn, false);
    });

    test('Should be user is null', () async {
      expect(authProvider.user, null);
    });

  });
}
