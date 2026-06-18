import 'package:flutter_test/flutter_test.dart';
import 'package:website_1_1/main.dart'; // Points to your newly named project

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Tell the tester to load your specific app class
    await tester.pumpWidget(const EmysCosmeticsApp());

    // Verify that the app successfully started by looking for the brand text
    expect(find.text("emy's"), findsWidgets);
  });
}
