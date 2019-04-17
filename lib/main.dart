import 'package:flutter/material.dart';
import 'list_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BodyLayout(),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _dataOrigin = ['Coca Cola', 'Leapfactor', 'Amazon'];
  List<String> _dataAmount = ['500', '125.50', '1235'];
  List<String> _dataDate = ['10/04/2019', '14/04/2019', '15/04/2019'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 500,
          width: 700,
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _dataOrigin.length,
            itemBuilder: (context, index, animation) {
              return ListItem(paymentOrigin: _dataOrigin[index], paymentAmount: _dataAmount[index], paymentDate: _dataDate[index]);
            },
          ),
        ),
        RaisedButton(
          child: Text('Insert item', style: TextStyle(fontSize: 20)),
          onPressed: () {
            _insertSingleItem();
          },
        ),
        RaisedButton(
          child: Text('Remove item', style: TextStyle(fontSize: 20)),
          onPressed: () {
            _removeSingleItem();
          },
        )
      ],
    );
  }

  void _insertSingleItem() {
    String newItem = "Leapfactor";
    String newItemA = "125";
    String newItemD = "14/03/2019";
    // Arbitrary location for demonstration purposes
    int insertIndex = _dataOrigin.length;
    // Add the item to the data list.
    _dataOrigin.insert(insertIndex, newItem);
    _dataAmount.insert(insertIndex, newItemA);
    _dataDate.insert(insertIndex, newItemD);
    // Add the item visually to the AnimatedList.
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = _dataOrigin.length - 1;
    // Remove item from data list but keep copy to give to the animation.
    String removedItem = _dataOrigin.removeAt(removeIndex);
    String removedItemA = _dataAmount.removeAt(removeIndex);
    String removedItemD = _dataDate.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return ListItem(paymentOrigin: removedItem, paymentAmount: removedItemA, paymentDate: removedItemD);
    };
    // Remove the item visually from the AnimatedList.
    _listKey.currentState.removeItem(removeIndex, builder);
  }
}
