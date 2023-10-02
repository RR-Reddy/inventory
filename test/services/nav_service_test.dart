import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory/service/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'nav_service_test.mocks.dart';

@GenerateMocks([GlobalKey<NavigatorState>, BuildContext, NavigatorState])
void main() {
  group('NavService +ve', () {
    final mockGlobalKey = MockGlobalKey<NavigatorState>();
    final mockBuildContext = MockBuildContext();
    final mockNavigatorState = MockNavigatorState();
    final navService = NavService(navigatorKey: mockGlobalKey);

    when(mockGlobalKey.currentContext).thenAnswer((_) => mockBuildContext);
    when(mockGlobalKey.currentState).thenAnswer((_) => mockNavigatorState);

    test('nav should not be null', () {
      expect(navService.nav, isNotNull);
    });

    test('context should not be a null', () {
      expect(navService.context, isNotNull);
    });
  });

  group('NavService -ve', () {
    final mockGlobalKey = MockGlobalKey<NavigatorState>();
    final navService = NavService(navigatorKey: mockGlobalKey);

    when(mockGlobalKey.currentContext).thenAnswer((_) => null);
    when(mockGlobalKey.currentState).thenAnswer((_) => null);

    test('nav should not be null', () {
      try {
        navService.nav;
        expect(0, 1);
      } catch (e) {
        expect(1, 1);
      }
    });

    test('context should not be a null', () {
      try {
        navService.context;
        expect(0, 1);
      } catch (e) {
        expect(1, 1);
      }
    });
  });
}
