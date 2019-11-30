import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:tabs/providers/filterState.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tabs/widgets/tabModal.dart';

class TabCard extends StatelessWidget {
  final DocumentSnapshot tab;
  TabCard({@required this.tab});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onLongPress: () {
          Provider.of<FilterState>(context).filterByName(this.tab["name"]);
        },
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => TabModal(
              tab: this.tab,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.tab["name"],
                style: Theme.of(context).textTheme.subhead,
              ),
              Text(
                FlutterMoneyFormatter(amount: this.tab["amount"])
                    .output
                    .symbolOnLeft,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Chip(
                backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                label: Text(
                  this.tab["description"],
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Expanded(
                child: Align(
                  child: Text(
                    timeago.format(this.tab["time"].toDate()),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
