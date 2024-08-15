import 'package:checkout/checkout_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CheckoutApp());

    expect(find.text('Market'), findsOneWidget);
  });
}
