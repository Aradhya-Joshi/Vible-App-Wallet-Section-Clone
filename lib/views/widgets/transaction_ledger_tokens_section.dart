import 'package:flutter/material.dart';

class TransactionLedgerTokensSection extends StatefulWidget {
  const TransactionLedgerTokensSection({super.key});

  @override
  State<TransactionLedgerTokensSection> createState() =>
      _TransactionLedgerTokensSectionState();
}

class _TransactionLedgerTokensSectionState
    extends State<TransactionLedgerTokensSection> {
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
