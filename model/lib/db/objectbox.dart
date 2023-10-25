import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart'; // created by `flutter pub run build_runner build`

late final Store store;

/// Create an instance of ObjectBox to use throughout the app.
Future createObjectBox() async {
  final docsDir = await getApplicationDocumentsDirectory();
  // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
  store = openStore(directory: p.join(docsDir.path, "default-db"));
}

extension BoxExtension<T> on Box<T> {
  Future<T?> findOneAsync() async {
    final query = this
        .query() // Order by ID in descending order
        .build();

    final T? entityWithLargestId = await query.findFirstAsync();
    query.close();
    return entityWithLargestId;
  }
}
