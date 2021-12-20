import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harry_challenge/Managers/network_manager.dart';
import 'package:harry_challenge/components/character_item.dart';
import 'package:harry_challenge/database/character_dao.dart';
import 'package:harry_challenge/main.dart';
import 'package:harry_challenge/models/character.dart';
import 'package:harry_challenge/models/favorite_character.dart';
import 'package:harry_challenge/screens/home_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'character_flow.mocks.dart';

@GenerateMocks([CharacterDao, NetworkManager])
void main() {
  testWidgets('Should open a character', (tester) async {
    var mockCharacterDao = MockCharacterDao();
    final mockNetworkManager = MockNetworkManager();

    final character = Character('Harry Potter', 'Gryffindor', 'Daniel Radcliffe', true, '31-07-1980', 'green', 'http://hp-api.herokuapp.com/images/harry.jpg');
    when(mockNetworkManager.getData()).thenAnswer((invocation) async {
      return [character];
    });

    await tester.pumpWidget(HarryChallenge(
      characterDao: mockCharacterDao,
      networkManager: mockNetworkManager,
    ));

    final homeScreen = find.byType(HomeScreen);
    expect(homeScreen, findsOneWidget);

    final fabFavoriteButton = find.widgetWithIcon(FloatingActionButton, Icons.favorite);
    expect(fabFavoriteButton, findsOneWidget);

    await tester.pumpAndSettle(
        Duration(seconds: 20), EnginePhase.build, Duration(minutes: 1));

    verify(mockNetworkManager.getData()).called(1);

    final characterItem = find.byWidgetPredicate((widget) {
      if (widget is CharacterItem) {
        return widget.character.name == 'Harry Potter';
      }
      return false;
    });
    expect(characterItem, findsOneWidget);
    // await tester.tap(characterItem);
    // await tester.pumpAndSettle(
    //     Duration(seconds: 20), EnginePhase.build, Duration(minutes: 1));

  });
}
