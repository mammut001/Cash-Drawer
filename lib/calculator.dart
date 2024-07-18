import 'package:flutter/material.dart';
import 'package:cash_drawer/dialog_box.dart';
import 'warning.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  double _fivecents = 0.0;
  double _tencents = 0.0;
  double _twofivecents = 0.0;
  double _loonie = 0.0;
  double _toonie = 0.0;
  double _five = 0.0;
  double _ten = 0.0;
  double _twenty = 0.0;
  double _fifty = 0.0;
  double _hundred = 0.0;
  double _total = 0.0;

  String newName = "";
  final TextEditingController _fivecentsController = TextEditingController();
  final TextEditingController _tenCentsController = TextEditingController();
  final TextEditingController _twofivecentsController = TextEditingController();
  final TextEditingController _loonieController = TextEditingController();
  final TextEditingController _toonieController = TextEditingController();
  final TextEditingController _fiveController = TextEditingController();
  final TextEditingController _tenController = TextEditingController();
  final TextEditingController _twentyController = TextEditingController();
  final TextEditingController _fiftyController = TextEditingController();
  final TextEditingController _hundredController = TextEditingController();

  final List<TextEditingController> _controllers = [];
  final List<String> _names = [];

  void _addController(String name){
    setState(() {
      _controllers.add(TextEditingController());
      _names.add(name);
      _controllers.last.addListener((){
        _updateTotal();
      });
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  void _updateTotal(){
    setState(() {
      _total = _fivecents + _tencents + _twofivecents + _loonie + _toonie + _five + _ten + _twenty + _fifty + _hundred;
      if(_controllers.isNotEmpty){
        _total += _controllers
            .map((controller) => double.tryParse(controller.text) ?? 0.0)
            .reduce((val, ele)=>val + ele);

      }
    });
  }

  @override
  void initState() {
    super.initState();

    _hundredController.addListener(() {
      final value = double.tryParse(_hundredController.text) ?? 0.0;
      if (value > 100) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showWarning(context);
        });
      } else {
        setState(() {
          _hundred = value * 100;
          _updateTotal();
        });
      }
    });

    _fiftyController.addListener(() {
      setState(() {
        _fifty = (double.tryParse(_fiftyController.text) ?? 0.0) * 50;
        _updateTotal();
      });
    });

    _twentyController.addListener(() {
      setState(() {
        _twenty = (double.tryParse(_twentyController.text) ?? 0.0) * 20;
        _updateTotal();
      });
    });

    _tenController.addListener(() {
      setState(() {
        _ten = (double.tryParse(_tenController.text) ?? 0.0) * 10;
        _updateTotal();
      });
    });

    _fiveController.addListener(() {
      setState(() {
        _five = (double.tryParse(_fiveController.text) ?? 0.0) * 5;
        _updateTotal();
      });
    });

    _toonieController.addListener(() {
      setState(() {
        _toonie = (double.tryParse(_toonieController.text) ?? 0.0) * 2;
        _updateTotal();
      });
    });

    _loonieController.addListener(() {
      setState(() {
        _loonie = (double.tryParse(_loonieController.text) ?? 0.0) * 1;
        _updateTotal();
      });
    });

    _twofivecentsController.addListener(() {
      setState(() {
        _twofivecents = (double.tryParse(_twofivecentsController.text) ?? 0.0) * 0.25;
        _updateTotal();
      });
    });

    _tenCentsController.addListener(() {
      setState(() {
        _tencents = (double.tryParse(_tenCentsController.text) ?? 0.0) * 0.1;
        _updateTotal();
      });
    });

    _fivecentsController.addListener(() {
      setState(() {
        _fivecents = (double.tryParse(_fivecentsController.text) ?? 0.0) * 0.05;
        _updateTotal();
      });
    });
  }

  void _showWarning(BuildContext ctx) async {
    final result = await showDialog<String>(
        context: ctx,
        builder: (BuildContext context){
          return Warning(msg: "ERROR");
        });

  }
  void _showDialog(BuildContext ctx) async{
    final returnedResultFromWidget = await showDialog<String>(
        context: ctx,
        builder: (BuildContext context){
          return const DialogBox();
        });

    if (returnedResultFromWidget != null && returnedResultFromWidget.isNotEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('$returnedResultFromWidget has been added')),
      );
      _addController(returnedResultFromWidget);

    }
    else{
      const SnackBar(content: Text('Canceled'));
    }
  }
  double _calculatePadding(BuildContext ctx) {
    double screenWidth = MediaQuery.of(ctx).size.width;

    if(kIsWeb){
      if (screenWidth > 600) {
        return 0.27 * screenWidth;
      } else {
        return 0.10 * screenWidth;
      }
    }
    else{
      return 0.12 * screenWidth;

    }
  }




  @override
  void dispose() {
    _controllers.map((controller)=> controller.dispose());

    _fivecentsController.dispose();
    _tenCentsController.dispose();
    _twofivecentsController.dispose();
    _loonieController.dispose();
    _toonieController.dispose();
    _fiveController.dispose();
    _tenController.dispose();
    _twentyController.dispose();
    _fiftyController.dispose();
    _hundredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _fivecentsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.05',
                    labelText: '\$0.05',

                  ),
                ),
              ),
              Text(
                _fivecents.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _tenCentsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.1',
                    labelText: '\$0.10',

                  ),
                ),
              ),
              Text(
                _tencents.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _twofivecentsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0.25',
                    labelText: '\$0.25',

                  ),
                ),
              ),
              Text(
                _twofivecents.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _loonieController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1',
                    labelText: 'Loonie',

                  ),
                ),
              ),
              Text(
                _loonie.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _toonieController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '2',
                    labelText: 'Toonie',


                  ),
                ),
              ),
              Text(
                _toonie.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _fiveController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '5',
                    labelText: '\$5',

                  ),
                ),
              ),
              Text(
                _five.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _tenController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '10',
                    labelText: '\$10',

                  ),
                ),
              ),
              Text(
                _ten.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _twentyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '20',
                    labelText: '\$20',

                  ),
                ),
              ),
              Text(
                _twenty.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _fiftyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '50',
                    labelText: '\$50',

                  ),
                ),
              ),
              Text(
                _fifty.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _hundredController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '100',
                    labelText: '\$100',
                  ),
                ),
              ),
              Text(
                _hundred.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),

          for (int i = 0; i < _controllers.length; i++)
            Padding(
                padding: EdgeInsets.only(
                  left: _calculatePadding(context),
                  right: _calculatePadding(context),
                  bottom: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: TextField(
                        controller: _controllers[i],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter value',
                          labelText: _names[i],
                        )),

                    )],
                )),
          const SizedBox(height: 10),

          Text(
            "Total: ${_total.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),

      ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
          tooltip: 'Add Item',
          child: const Icon(Icons.add),
    ),
    );

  }
}