import 'package:flutter/material.dart';
import 'package:td_app/view/common/appbar.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), 
        child: CommonAppbar()
      ),
    );
  }
}