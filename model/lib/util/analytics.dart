

import 'package:firebase_analytics/firebase_analytics.dart';

import 'logger.dart';

class Analytics {
  final Logger _logger = Logger(Analytics);

  static Analytics get instance {
    Analytics instance = Analytics();
    return instance;
  }

  void report(String event, [Map<String, Object?>? parameters]) {
    _logger.debug('report', parameters);
    FirebaseAnalytics.instance.logEvent(
      name: event,
      parameters: parameters,
    );
  }
}
