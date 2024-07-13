import 'package:cash_drawer/dialog_box.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cash Drawer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      setState(() {
        _hundred = (double.tryParse(_hundredController.text) ?? 0.0) * 100;
        _updateTotal();
      });
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('5 Cents'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _fivecents.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('10 Cents'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _tencents.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('25 Cents'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _twofivecents.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Loonie'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _loonie.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Toonie'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _toonie.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('\$5'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _five.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('\$10'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _ten.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('\$20'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _twenty.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('\$50'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _fifty.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('\$100'),
                ),
              ),
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
                      ),
                    ),
                  ),
                  Text(
                    _hundred.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              for (int i = 0; i < _controllers.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: _controllers[i],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Enter value',
                                  labelText: _names[i],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
