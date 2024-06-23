import 'package:flutter/material.dart';

class TransactionLedgerActivitySection extends StatefulWidget {
  const TransactionLedgerActivitySection({super.key});

  @override
  State<TransactionLedgerActivitySection> createState() =>
      _TransactionLedgerActivitySectionState();
}

class _TransactionLedgerActivitySectionState
    extends State<TransactionLedgerActivitySection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const ListTile(
          leading: CircleAvatar(),
          title: Text('VIBLE'),
          trailing: Text('5 \$VIBLE'),
        );
      },
    );
  }
}
