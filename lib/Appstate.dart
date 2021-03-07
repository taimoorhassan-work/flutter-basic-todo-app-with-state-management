import 'package:states_rebuilder/states_rebuilder.dart';



var appState = RM.inject(() => _AppState());

class _AppState {
  List<String> todo = [];
}