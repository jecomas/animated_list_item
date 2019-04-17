import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
 * Custom animation for AnimatedList
 */

class ListItem extends StatefulWidget {
  ListItem({Key key, this.paymentOrigin, this.paymentAmount, this.paymentDate}) : super(key: key);

  final String paymentOrigin;
  final String paymentAmount;
  final String paymentDate;

  @override
  State<StatefulWidget> createState() => ListItemState();
}

class ListItemState extends State<ListItem> with SingleTickerProviderStateMixin {
//SingleTickerProviderStateMixin (implements TikerProvider) provides only one Tiker. We have a single AnimationController.

  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500)); // basically, goes from on double value to another in the time specified.

    offset = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller); //gives us a linear interpolation between two values of any type given a moment

    controller.forward();
  }

  Widget build(BuildContext context) {
    final f = new NumberFormat.currency(decimalDigits: 2, locale: "en_US", symbol: "USD ");
    final amount = f.format(double.parse(widget.paymentAmount));
    return new Material(
        type: MaterialType.transparency,
        child: new SlideTransition(
            position: offset,
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: new Row(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: new CircleAvatar(
                            backgroundColor: Colors.red,
                            child: new Icon(Icons.access_alarm, color: Colors.white),
                          )),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.paymentOrigin,
                            style: new TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          new Text(
                            amount,
                            style: new TextStyle(color: Colors.blueGrey, fontSize: 15, fontWeight: FontWeight.w900, fontFamily: "Roboto"),
                          )
                        ],
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Text(
                            widget.paymentDate,
                            style: new TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          new CircleAvatar(
                            backgroundColor: Colors.white,
                            child: new Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Colors.green,
                            ),
                          )
                        ],
                      )),
                    ],
                  )),
            )));
  }
}
