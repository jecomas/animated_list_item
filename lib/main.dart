import 'package:flutter/material.dart';
import 'list_item.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Animated List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = new ScrollController();

  void _addItem() {
    setState(() {
      dataOrigin.insert(0, 'Otra');
      dataAmount.insert(0, '1255');
      dataDate.insert(0, '15/04/22');
      _scrollController.animateTo(dataOrigin.length * ITEM_HEIGHT, duration: new Duration(seconds: 2), curve: Curves.ease);
    });
  }

  void _removeItem() {
    setState(() {
      dataOrigin.removeAt(0);
      dataAmount.removeAt(0);
      dataDate.removeAt(0);
      _scrollController.animateTo(dataOrigin.length * ITEM_HEIGHT, duration: new Duration(seconds: 2), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: new ListView.builder(
              controller: _scrollController,
              reverse: true,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: dataOrigin.length,
              itemBuilder: (context, index) {
                return ListItem(paymentOrigin: dataOrigin[index], paymentAmount: dataAmount[index], paymentDate: dataDate[index]);
              }),
        ),
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          FloatingActionButton(
            onPressed: _addItem,
            tooltip: 'Add',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _removeItem,
            tooltip: 'Remove',
            child: Icon(Icons.remove),
          ),
        ])
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
