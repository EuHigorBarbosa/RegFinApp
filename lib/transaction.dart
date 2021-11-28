import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;
  dynamic majorNumber = NumberFormat.compact();
  dynamic formatTresMaisDois = NumberFormat('##0.00', 'pt_BR');
  dynamic formatQuatroMaisUm = NumberFormat('#,##0.0', 'pt_BR');
  dynamic formatCincoMaisZero = NumberFormat('####0', 'pt_BR');

  Transaction({
    required this.date,
    required this.id,
    required this.title,
    required this.value,
  });

  String get formatedStringValue {
    if (value > 99999) {
      return majorNumber.format(double.tryParse(value.toStringAsFixed(0)));
    } else if (value > 9999.9) {
      return formatCincoMaisZero
          .format(double.tryParse(value.toStringAsFixed(0)));
    } else if (value > 999.99) {
      return formatQuatroMaisUm
          .format(double.tryParse(value.toStringAsFixed(1)));
    } else if (value > 0) {
      return formatTresMaisDois
          .format(double.tryParse(value.toStringAsFixed(2)));
    } else
      return 'NaN';
  }
}
