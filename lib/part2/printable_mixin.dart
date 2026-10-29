/// Примесь (Mixin) для логирования и форматирования информации об объектах.
mixin PrintableInfo {
  /// Выводит структурированное сообщение в консоль с префиксом источника.
  void printLog(String message, {String level = 'INFO'}) {
    final now = DateTime.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    print('[$timeStr] [$level] $message');
  }

  /// Возвращает стилизованный баннер для заголовков карточек.
  String formatHeader(String title, {int width = 50}) {
    final border = '═' * width;
    final padding = (width - title.length - 2) ~/ 2;
    final leftPad = ' ' * (padding > 0 ? padding : 0);
    final rightPad = ' ' * (width - title.length - 2 - leftPad.length);
    return '$border\n║$leftPad$title$rightPad║\n$border';
  }

  /// Возвращает текстовый значок статуса заполненности клуба.
  String formatFillStatus({required int current, required int max}) {
    final percentage = max > 0 ? (current / max * 100).round() : 0;
    if (percentage >= 100) {
      return '[Заполнен 100%]';
    } else if (percentage >= 80) {
      return '[Почти заполнен $percentage%]';
    } else {
      return '[Свободно мест: ${max - current} ($percentage%)]';
    }
  }
}
