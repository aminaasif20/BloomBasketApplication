import 'package:flutter_test/flutter_test.dart';
import 'package:bloombasket/main.dart';
import 'package:provider/provider.dart';
import 'package:bloombasket/providers/app_state.dart';

void main() {
  testWidgets('App starts with Splash Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We wrap it in the provider to match the real main.dart setup
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: const BloomBasketApp(),
      ),
    );

    // Verify that our app starts and shows the Splash Screen branding.
    expect(find.text('BLOOMBASKET'), findsOneWidget);
    expect(find.text('BOTANICAL PRESTIGE'), findsOneWidget);
  });
}
