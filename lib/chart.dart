import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registrofinanceiro/transaction.dart';
//import 'package:percent_indicator/percent_indicator.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  final dynamic majorNumber = NumberFormat.compact();
  final dynamic formatTresMaisDois = NumberFormat('##0.00', 'pt_BR');
  final dynamic formatQuatroMaisUm = NumberFormat('#,##0.0', 'pt_BR');
  final dynamic formatCincoMaisZero = NumberFormat('####0', 'pt_BR');

  Chart({required this.recentTransaction});

//Essa funcão é do tipo getter
  List<Map<String, Object>> get groupedTransactions {
    List<Map<String, Object>> saida = List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          bool sameDay = recentTransaction[i].date.day == weekDay.day;
          bool sameMonth = recentTransaction[i].date.month == weekDay.month;
          bool sameYear = recentTransaction[i].date.year == weekDay.year;
          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransaction[i].value;
          }
        }

        print('A letra do dia é: ${DateFormat.E().format(weekDay)[0]}');
        print('O valor da soma do dia é: $totalSum');

        return {
          'day': DateFormat.E().format(weekDay)[0], //pega a primeira letra
          'value': totalSum,
        };
      },
    ).reversed.toList();
    print(saida);
    return saida;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  String formatedDoubledValue(double value) {
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
      return 'Nada';
  }
  // List<double> get proporsionalReturn {
  //   return List.generate(7, (index) {
  //     double weekTotalvalue = 0;
  //     for (int i = 0; i < groupedTransactions.length; i++) {
  //       weekTotalvalue = groupedTransactions[i].cast()['value'];
  //     }
  //     print('O valor total da semana é $weekTotalvalue');
  //     print(
  //         'O valor do dia $index da semana é ${groupedTransactions[index].cast()['value']}');
  //     return groupedTransactions[index].cast()['value'] / weekTotalvalue;
  //     //groupedTransactions[0]['value']/sum
  //   });
  // }

  /*
0 - depende do dia de hoje...

na coluna 6  será sempre now
na 5 será sempre hoje  now -1
na 4 será sempre hoje now -2
na 3 será sempre hoje now -3
na 2 será sempre hoje now -4
na 1 será sempre hoje now -5
na 0 sermpre hoje now -6

*/

  @override
  Widget build(BuildContext context) {
    //groupedTransactions;
    // proporsionalReturn;
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[0]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[1]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[2]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[3]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[4]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[5]}');
    // print('O valor de ProporsionaReturn é: ${proporsionalReturn[6]}');

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[0]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[0]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[0]['value'] as double)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[1]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[1]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[1]['value'] as double)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[2]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[2]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[2]['value'] as double)),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${groupedTransactions[3]['day']}'),
                    Expanded(
                        child: RotatedBox(
                      quarterTurns: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                        color: Theme.of(context).primaryColor,
                        value: (_weekTotalValue == 0)
                            ? 0.0
                            : (groupedTransactions[3]['value'] as double) /
                                _weekTotalValue,
                        minHeight: 7,
                      ), // Is supposed to extend as far as possible
                    )),
                    Text(formatedDoubledValue(
                        groupedTransactions[3]['value'] as double)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[4]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[4]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[4]['value'] as double)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[5]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[5]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[5]['value'] as double)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${groupedTransactions[6]['day']}'),
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
                      color: Theme.of(context).primaryColor,
                      value: (_weekTotalValue == 0)
                          ? 0.0
                          : (groupedTransactions[6]['value'] as double) /
                              _weekTotalValue,
                      minHeight: 7,
                    ), // Is supposed to extend as far as possible
                  )),
                  Text(formatedDoubledValue(
                      groupedTransactions[6]['value'] as double)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
