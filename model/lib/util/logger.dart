import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

class Logger {
  final String tag;

  Logger(dynamic tag)
      : tag = tag is Type ? tag.toString() : tag as String;

  void log(String message, {LogLevel level = LogLevel.debug}) {
    print('$tag $message');
    developer.log(
      message,
      name: tag,
      level: _getLogLevelValue(level),
    );
  }

  int _getLogLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 1;
      case LogLevel.info:
        return 2;
      case LogLevel.warning:
        return 3;
      case LogLevel.error:
        return 4;
      default:
        return 0;
    }
  }

  void _logWithOptionalParameters(String message, LogLevel level, [List<Object?>? optionalParameters]) {
    final buffer = StringBuffer(message);

    if (optionalParameters != null && optionalParameters.isNotEmpty) {
      buffer.write(': ');
      buffer.writeAll(optionalParameters.map((e) => e.toString()), ', ');
    }

    log(buffer.toString(), level: level);
  }

  void debug(String message, [Object? optionalParameter1, Object? optionalParameter2, Object? optionalParameter3]) {
    _logWithOptionalParameters(message, LogLevel.debug, [optionalParameter1, optionalParameter2, optionalParameter3].where((e) => e != null).toList());
  }

  void info(String message, [Object? optionalParameter1, Object? optionalParameter2, Object? optionalParameter3]) {
    _logWithOptionalParameters(message, LogLevel.info, [optionalParameter1, optionalParameter2, optionalParameter3].where((e) => e != null).toList());
  }

  void warning(String message, [Object? optionalParameter1, Object? optionalParameter2, Object? optionalParameter3]) {
    _logWithOptionalParameters(message, LogLevel.warning, [optionalParameter1, optionalParameter2, optionalParameter3].where((e) => e != null).toList());
  }

  void error(String message, [Object? optionalParameter1, Object? optionalParameter2, Object? optionalParameter3]) {
    _logWithOptionalParameters(message, LogLevel.error, [optionalParameter1, optionalParameter2, optionalParameter3].where((e) => e != null).toList());
  }
}
