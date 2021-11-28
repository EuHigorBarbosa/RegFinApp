import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)
      funcaoAddNewTransactionOnSubmitUser;
  //! Essa função tem o nome de onSubmit no arquivo do professor
  //ele construiu aqui um atributo variavel do tipo Function.
  //Esse atributo será utilizado no seu construtor. Então toda vez
  //que alguem quiser construir um Transaction_form ele vai ter que passar
  //uma função no mesmo modelo requerido no seu construtor

  TransactionForm({required this.funcaoAddNewTransactionOnSubmitUser});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    //Como submeteremos os dados mais de uma vez no programa vamos criar essa função
    //quando o user apertar o botão, então o construtor de
    // TransactionForm será chamado.
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    //Se acontecer de os valores dos textFields não forem válidos retorna nada.
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.funcaoAddNewTransactionOnSubmitUser(title, value, _selectedDate);
    //? Pra usar essa função funcaoAddNewTransactionOnSubmitUser aqui eu preciso
    //? de uma comunicação entre a classe _TransactionFormState e
    //? TransactionForm. Essa comunicação entre classes possibilita o uso de
    //? qualquer atributo da classe que não é a state. Essa comunicação
    //? se dá por meio dessa palavrinha widget. e aí vc coloca o atributo que quiser
  }

  _showDatePicker() {
    //o contex é recebido por herança assim como o widget. que é
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      print('Executado dentro da tela!');
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('Executado!!!!');
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );
  @override
  Widget build(BuildContext context) {
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    final tamanhoSafeArea = MediaQuery.of(context).size.height;
    var compensation = 0.0;

    if (keyboardSize > 0) {
      compensation = keyboardSize / tamanhoSafeArea;
    }

    return makeDismissible(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        height: keyboardSize + 252,
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    //onChanged: (newTitle) => title = newTitle,
                    //Não teremos o evento onCheged pois vou usar o controller
                    controller: _titleController,
                    autofocus: true,
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      // border: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.green, width: 3.0),
                      // ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                      ),
                      labelText: 'Digite o Título',

                      //enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    style: Theme.of(context).textTheme.headline6,

                    //onChanged: (newValue) => value = newValue,
                    controller: _valueController,
                    onSubmitted: (value) => _submitForm(),
                    //!MALANDRAGEM - uso da função sem parametro num lugar que pede parametro
                    //! Tambem funciona se utilizarmos (_) => _submitForm()
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    //Esse comando cria o teclado númerico e faz com que funcione tanto
                    //no android quantono ios
                    decoration: InputDecoration(
                      labelText: 'Digite o valor (R\$)',
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Text(_selectedDate == null
                              ? 'Nenhuma data selecionada'
                              : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                        ),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton(
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Nova data',
                                )),
                            onPressed: _showDatePicker,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            textStyle: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Adicionar Transação',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
