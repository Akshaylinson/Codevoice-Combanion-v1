import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.pages,
    required this.labels,
    required this.icons,
  }) : assert(pages.length == labels.length && labels.length == icons.length);

  final List<Widget> pages;
  final List<String> labels;
  final List<IconData> icons;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _index, children: widget.pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          for (var i = 0; i < widget.pages.length; i++)
            NavigationDestination(
              icon: Icon(widget.icons[i]),
              label: widget.labels[i],
            ),
        ],
      ),
    );
  }
}
