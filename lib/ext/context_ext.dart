import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

extension ProviderExtension on BuildContext {
  T provide<T>({bool listen = false}) => Provider.of<T>(this, listen: listen);
  T inject<T>() => Provider.of<T>(this, listen: false);
}
