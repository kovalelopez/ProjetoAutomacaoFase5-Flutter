import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;
import 'json.dart';



void main() {

final List<TestResult> results = [];

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  tearDown(() async {
    await Future.delayed(Duration(seconds: 2));
  
  });
  tearDownAll(() => enviarDadosComoJson(results));
    group('teste end-to-end', () {
    testWidgets('Validação do título',
        (tester) async {
           results.add(TestResult(title: 'Validação do título', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.text('Rick and Morty'), findsOneWidget);

   results.last.approved = true;
    });

    testWidgets('Validação da descrição',
        (tester) async {
           results.add(TestResult(title: 'Validação da descrição', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.text('Procupero pelo seu personagem'), findsOneWidget);

   results.last.approved = true;
    });

    testWidgets('Validação do imput de pesquisa',
        (tester) async {
           results.add(TestResult(title: 'Validação do imput de pesquisa', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.byKey(const Key('Filtro')), findsOneWidget);
      expect( find.byIcon(Icons.search), findsOneWidget);
   results.last.approved = true;
    });

    testWidgets('Validação menu hamburger',
        (tester) async {
           results.add(TestResult(title: 'Validação do menu hamburguer', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.byIcon(Icons.list), findsOneWidget);
      await tester.tap(find.byIcon(Icons.list));
      await Future.delayed(Duration(seconds: 1));
      expect( find.byIcon(Icons.grid_view), findsOneWidget);
      await tester.tap(find.byIcon(Icons.grid_view));
      await Future.delayed(Duration(seconds: 1));
      expect( find.byIcon(Icons.list), findsOneWidget);
   results.last.approved = true;
    });

    testWidgets('Validação do card no ListView',
        (tester) async {
           results.add(TestResult(title: 'Validação do card no ListView', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.byKey(const Key('imageCard')), findsWidgets);
      expect( find.text('Rick Sanchez'), findsWidgets);
      expect( find.text('Alive - Human'), findsWidgets);
      expect( find.text('Male'), findsWidgets);
      expect( find.text('1'), findsWidgets);
   results.last.approved = true;
    });

    testWidgets('Validação do card no GrindView',
        (tester) async {
           results.add(TestResult(title: 'Validação do card no GrindView', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.byIcon(Icons.list), findsOneWidget);
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      expect( find.text('1'), findsWidgets);
      expect( find.byKey(Key('imageCard2')), findsWidgets);
      expect( find.text('Rick Sanchez'), findsWidgets);
   results.last.approved = true;
    });

      testWidgets('Validação da pesquisa',
        (tester) async {
           results.add(TestResult(title: 'Validação da pesquisa', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.byKey(Key('Filtro')), findsOneWidget);
      await tester.enterText(find.byKey(Key('Filtro')), 'Alan Rails');
      await tester.pump();
      await Future.delayed(Duration(seconds: 1));
      await tester.pump();
      expect( find.byKey(Key('imageCard')), findsWidgets);
      expect( find.text('Alan Rails'), findsWidgets);
      expect( find.text('Dead - Human'), findsWidgets);
      expect( find.text('Male'), findsWidgets);
      expect( find.text('10'), findsWidgets);
      await Future.delayed(Duration(seconds: 1));
      expect( find.byIcon(Icons.list), findsOneWidget);
      await tester.tap(find.byIcon(Icons.list));
      await tester.pump();
      expect( find.text('10'), findsWidgets);
      expect( find.byKey(Key('imageCard2')), findsWidgets);
      expect( find.text('Alan Rails'), findsWidgets);
   results.last.approved = true;
    });

     testWidgets('Validação da tela de detalhes',
        (tester) async {
           results.add(TestResult(title: 'Validação da tela de detalhes', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect( find.text('Rick Sanchez'), findsWidgets);
      await tester.tap(find.text('Rick Sanchez'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('imageDetails')), findsOneWidget);
      expect( find.text('RICK SANCHEZ | #1'), findsWidgets);
      expect( find.text('Alive'), findsWidgets);
      expect( find.text('Human'), findsWidgets);
      expect( find.text('Male'), findsWidgets);
      expect( find.text('Última localização conhecida: '), findsWidgets);
      expect( find.text('Local de origem: '), findsWidgets);
      expect( find.text('Earth (C-137)'), findsWidgets);
      await Future.delayed(Duration(seconds: 1));
      expect( find.text('Quantidades de vezes que apareceu: '), findsWidgets);

   results.last.approved = true;
    });

      testWidgets('Validação de retornar a tela inicial',
        (tester) async {
           results.add(TestResult(title: 'Validação de retornar a tela incial', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect(find.text('Rick Sanchez'), findsWidgets);
      await tester.tap(find.text('Rick Sanchez'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('imageDetails')), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect( find.text('Rick Sanchez'), findsWidgets);

      results.last.approved = true;
  });

  testWidgets('Validação de scroll',
        (tester) async {
           results.add(TestResult(title: 'Validação de scroll', approved: false));
      app.main();
      await tester.pumpAndSettle();
      
      expect(find.text('Rick Sanchez'), findsWidgets);
      await tester.drag(find.text('Rick Sanchez'), const Offset(0, -20000));
      await Future.delayed(Duration(seconds: 4));

      results.last.approved = true;
  });
    
   });

}