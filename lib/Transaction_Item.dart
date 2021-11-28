import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registrofinanceiro/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final void Function(String p1) functionRemove;

  const TransactionItem({
    Key? key,
    required this.tr,
    required this.functionRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  'R\$${tr.formatedStringValue}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            tr.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(DateFormat('d MMM y').format(tr.date),
              style: TextStyle(
                color: Colors.grey,
              )),
          trailing: MediaQuery.of(context).size.width > 450
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    children: [
                      Text(
                        'remover',
                      ),
                      IconButton(
                          onPressed: () => functionRemove(tr.id),
                          //! ele chama sem parametro () uma função que requer parametro....isso é sensacional
                          icon: Icon(Icons.delete_forever),
                          color: Theme.of(context).errorColor)
                    ],
                  ),
                )
              : IconButton(
                  onPressed: () => functionRemove(tr.id),
                  //! ele chama sem parametro () uma função que requer parametro....isso é sensacional
                  icon: Icon(Icons.delete_forever),
                  color: Theme.of(context).errorColor)),
    );
  }
}
