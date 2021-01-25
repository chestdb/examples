import 'package:chest/chest.dart';

final counter = Chest('counter', ifNew: () => 0);

void main() async {
  tape.register({
    ...tapers.forDartCore, // contains a taper for int
  });
  await counter.open();
  final count = counter.value;
  print('This program ran $count ${count == 1 ? 'time' : 'times'}.');
  counter.value++;
  await counter.close();
}
