import 'package:flutter/material.dart';
import 'package:vible_wallet_clone/style/global_consts.dart';
import 'package:vible_wallet_clone/views/widgets/transaction_ledger_activity_section.dart';
import 'package:vible_wallet_clone/views/widgets/transaction_ledger_tokens_section.dart';

class TransactionLedgerSection extends StatefulWidget {
  const TransactionLedgerSection({
    super.key,
  });

  @override
  State<TransactionLedgerSection> createState() =>
      _TransactionLedgerSectionState();
}

class _TransactionLedgerSectionState extends State<TransactionLedgerSection> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const TransactionLedgerTokensSection(),
    const TransactionLedgerActivitySection(),
  ];

  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                _selectedIndex = 0;
                _pageViewController.animateToPage(
                  _selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
              child: SizedBox(
                width: GlobalStyleVariables.screenWidth * 0.35,
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      'Tokens',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: _selectedIndex == 0
                            ? TextDecoration.combine(
                                [TextDecoration.underline],
                              )
                            : null,
                        decorationColor: Colors.black,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ],
                )),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                _selectedIndex = 1;
                _pageViewController.animateToPage(
                  _selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }),
              child: SizedBox(
                width: GlobalStyleVariables.screenWidth * 0.35,
                child: Center(
                    child: Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: _selectedIndex == 1
                        ? TextDecoration.combine(
                            [TextDecoration.underline],
                          )
                        : null,
                    decorationColor: Colors.black,
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: GlobalStyleVariables.screenHeight * 0.5,
          child: PageView.builder(
            controller: _pageViewController,
            itemCount: pages.length,
            onPageChanged: (newPageIndex) {
              setState(() {
                _selectedIndex = newPageIndex;
              });
            },
            itemBuilder: (context, index) {
              return pages[index];
            },
            pageSnapping: true,
            physics: const ClampingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
