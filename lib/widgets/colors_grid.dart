import 'package:flutter/material.dart';

///color grid class
class ColorsGrid extends StatelessWidget {
  ///list of colors to display
  final List<Color> colorsList;

  ///callback f
  final void Function(Color) handleColorDelete;

  ///callback f
  final void Function(Color) handlelocalColorDelete;

  ///constructor
  const ColorsGrid({
    super.key,
    required this.colorsList,
    required this.handlelocalColorDelete,
    required this.handleColorDelete,
  });

  @override
  Widget build(BuildContext context) {
    ///popup menuF
    Future<void> _popUpDeleteMenu(BuildContext context, Color color) async {
      final confirmed = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Confirmation'),
          content: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Are you sure you want to delete this color?'),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: color,
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
      if (confirmed == true) {
        handleColorDelete(color);
        handlelocalColorDelete(color);
      }
    }

    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 75,
        childAspectRatio: 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      children: [
        ...colorsList
            .toSet()
            .map(
              (clr) => GestureDetector(
                onLongPress: () => _popUpDeleteMenu(context, clr),
                child: CircleAvatar(
                  backgroundColor: clr,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
