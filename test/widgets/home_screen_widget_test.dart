import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harry_challenge/Managers/network_manager.dart';
import 'package:harry_challenge/database/character_dao.dart';
import 'package:harry_challenge/screens/home_screen.dart';
import 'package:harry_challenge/widgets/app_dependencies.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../flow/character_flow.mocks.dart';

@GenerateMocks([CharacterDao, NetworkManager])
main() {
  testWidgets('Should display the main image when the app start',
      (tester) async {
    var mockCharacterDao = MockCharacterDao();
    final mockNetworkManager = MockNetworkManager();

    when(mockNetworkManager.getData()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      AppDependencies(
        networkManager: mockNetworkManager,
        characterDao: mockCharacterDao,
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  testWidgets('Should display the favorite button', (tester) async {
    var mockCharacterDao = MockCharacterDao();
    final mockNetworkManager = MockNetworkManager();

    when(mockNetworkManager.getData()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      AppDependencies(
        networkManager: mockNetworkManager,
        characterDao: mockCharacterDao,
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    final fabFavoriteItem =
        find.widgetWithIcon(FloatingActionButton, Icons.favorite);
    expect(fabFavoriteItem, findsOneWidget);
  });
}
