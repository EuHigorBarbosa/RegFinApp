import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registrofinanceiro/chart.dart';
import 'package:registrofinanceiro/transaction_form.dart';
import 'dart:math';
import 'package:registrofinanceiro/transaction.dart';
import 'package:registrofinanceiro/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionListBancoDeDadosInicial = [
    Transaction(
        date: DateTime.now().subtract(Duration(days: 33)),
        id: 't0',
        title: 'Novo tênis de corrida',
        value: 310.76),
    Transaction(
        date: DateTime.now(),
        id: 't1',
        title: 'Novo tênis de corrida',
        value: 180000),
    Transaction(
        date: DateTime.now().subtract(Duration(days: 6)),
        id: 't2',
        title: 'Novo tênis de corrida',
        value: 18),
    Transaction(
        date: DateTime.now().subtract(Duration(days: 4)),
        id: 't3',
        title: 'Nova bolsa',
        value: 180000999),
    Transaction(
        date: DateTime.now().subtract(Duration(days: 3)),
        id: 't4',
        title: 'Novo tênis de corrida',
        value: 180000999),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 3)),
      id: 't5',
      title: 'Despesa 1 de 3 dias atras',
      value: 100,
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 3)),
      id: 't6',
      title: 'despesa 2 de 3 dias atras',
      value: 100,
    ),
  ];
//Esse getter vai ser responsável por passar as transações recentes para nosso
//componente chart. A ideia é filtrar...de todas as transações que existem
//eu mostrarei apenas as dos ultimos 7 dias.
  List<Transaction> get _recentTransactions {
    return _transactionListBancoDeDadosInicial.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
        //Se a data for depois de uma data subtraida de 7 dias, então
        // entra pois é depois de 7 dias atrás = dentro do período entre
        //hoje e 7 dias atras.
      ));
    }).toList();
  }

  dynamic _addTransaction(String argTitle, double argValue, DateTime date) {
    final newTransaction = Transaction(
        date: date,
        id: Random().nextDouble().toString(),
        title: argTitle,
        value: argValue);
    //? --- Esse set serve para atualizar o estado do componente stateful que é o TransactionUser
    //? -- Logicamente será chamado depois de haver sido criado um objeto do tipo List<Transaction>
    setState(() {
      _transactionListBancoDeDadosInicial.add(newTransaction);
    });
    //Aqui há uma modificação do atributo da classe _TransactionUserState por meio de
    //uma adição.
    Navigator.of(context).pop();
    //Esse navigator serve para fechar o teclado quando clica no submit
    //Existe uma explicação muito interessante na aula 116
  }

  _removeTransaction(String idInput) {
    setState(() {
      //Esse setState vai modificar o estado da lista quando removermos o dado
      _transactionListBancoDeDadosInicial
          .removeWhere((element) => element.id == idInput);
    });
  }

  String value = ''; //?retirar pois acho que isso não está sendo usado
  _openTransactionFormModal(BuildContext context) {
    //Essa função vai simplesmente mostrar os textfilds para que o operador cadastre
    //uma nova transação
    //Esse build context no argumento dela eu não entendo pra que, o prof que colocou
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (ctxAleatorio) {
          return TransactionForm(
              funcaoAddNewTransactionOnSubmitUser: _addTransaction);
          //! Essa parte aqui fui eu que coloquei...o professor pois null mas
          //! não entendo pq o dele funcionou com null - Aula 113
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBarCriada = AppBar(
      title: Text(
        'Despesas Pessoais',
        // style: TextStyle(
        //   fontFamily: 'OpenSans',
        // ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          //! Eu não tenho a minima noção do que é o uso do context aqui e pq funcionou
          //! sendo que
          icon: Icon(Icons.add),
        ),
      ],
    );

    var availableHeight = MediaQuery.of(context).size.height -
        appBarCriada.preferredSize.height -
        MediaQuery.of(context).padding.top;
    print('esse é o availableHeight DECALARACAO: $availableHeight');
    Container categoryDivider() {
      return Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width - 20.0,
        color: Theme.of(context).secondaryHeaderColor,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      );
    }

    return Scaffold(
      appBar: appBarCriada,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          print(
              'esse é o MediaQuery.of(context).size.height declaração: ${MediaQuery.of(context).size.height}');
          print(
              'esse é o MediaQuery.of(context).size.width PHONE: ${MediaQuery.of(context).size.width}}');
          print(
              'esse é o appBarCriada.preferredSize.height PHONE: ${appBarCriada.preferredSize.height}}');
          print(
              'esse é o MediaQuery.of(context).padding.top PHONE: ${MediaQuery.of(context).padding.top}}');
          print('esse é o availableHeight PHONE: $availableHeight');
          print('constraints.maxWidth : ${constraints.maxWidth}');
          print('constraints.maxHeight : ${constraints.maxHeight}');
          print('\n\n\n====================================');
          //? ======================= COLUNA DO GRAFICO P PHONE ===============
          return ListView(
            children: <Widget>[
              Container(
                height: availableHeight * 0.2,
                child: Chart(recentTransaction: _recentTransactions),
              ),
              categoryDivider(),
              //* =============== COLUNA DO LISTVIEW PHONE ============
              Container(
                height: availableHeight * 0.8,
                child: TransactionList(
                    transactionsInsertedForRendering:
                        _transactionListBancoDeDadosInicial,
                    functionRemove: _removeTransaction),
              ),
              //o componente pai General passa para o filho TransactionList
              //uma função que será usada pelo filho quando houver o evento
              //que no caso é o apertar do icone delete_forever na lista
            ],
          );
        } else {
          print('esse é o availableHeight LANDSCAPE: $availableHeight');
          //? Sendo LANDSCAPE - Large screens (tablet on landscape mode, desktop, TV)

          //? ============== COLUNA DO GRAFICO PARA LANDSCAPE ====================
          return ListView(
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Center(
                child: Container(
                  height: availableHeight * 0.6,
                  width: availableHeight * 1.4,
                  child: Chart(recentTransaction: _recentTransactions),
                ),
              ),
              Container(
                color: Colors.white,
                //height: 250,
                width: 480,
                child: TransactionList(
                    transactionsInsertedForRendering:
                        _transactionListBancoDeDadosInicial,
                    functionRemove: _removeTransaction),
              ),
              // Expanded(
              //   child: Container(
              //     height: 20,
              //     width: 50,
              //     color: Colors.black,
              //   ),
              // ),
              // Text('sssssss'),
            ],
          );
          // TransactionList(
          //     transactionsInsertedForRendering:
          //         _transactionListBancoDeDadosInicial,
          //     functionRemove: _removeTransaction),

          // ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: [
          // FittedBox(
          //   fit: BoxFit.none,
          //   child: Container(
          //     height: availableHeight * 0.5,
          //     width: availableHeight * 1,
          //     child: Chart(recentTransaction: _recentTransactions),
          //   ),
          // ),
          // Flexible(
          //     fit: FlexFit.loose,
          //     child: Container(
          //       height: availableHeight,
          //       width: 600,
          //       color: Colors.green,
          //       child: Flexible(
          //         fit: FlexFit.tight,
          //         child: FittedBox(
          //           fit: BoxFit.contain,
          //           child: Text('hehehehe2hehehe'),
          // TransactionList(
          //     transactionsInsertedForRendering:
          //         _transactionListBancoDeDadosInicial,
          //     functionRemove: _removeTransaction),
          //         ),
          //       ),
          //     )),
          //   ],
          // );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
/*
Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: availableHeight * 0.4,
                    width: 600,
                    child: Chart(recentTransaction: _recentTransactions),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TransactionList(
                        transactionsInsertedForRendering:
                            _transactionListBancoDeDadosInicial,
                        functionRemove: _removeTransaction),
                  ),
                  // ElevatedButton(
                  //   child: Text('Nova data'),
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.purple,
                  //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //     textStyle: Theme.of(context).textTheme.headline6,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // Text('ola vc ai'),
                  // Container(),
                ],
              ),
*/