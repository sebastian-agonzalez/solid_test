import 'package:flutter/material.dart';

import 'package:solid_task_project/screens/home_screen.dart';
import 'package:solid_task_project/widgets/colors_grid.dart';

///Favorite Screen class
class FavoritesScreen extends StatefulWidget {
  ///list of fav colors
  final List<Color> favColorsList;

  ///callback f
  final void Function(Color) handleColorDelete;

  ///constructor
  const FavoritesScreen({
    super.key,
    required this.favColorsList,
    required this.handleColorDelete,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          ),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: widget.favColorsList.isEmpty
          ? const Center(child: Text('No colors to see yet.'))
          : Column(
              children: [
                Expanded(
                  flex: 9,
                  child: ColorsGrid(
                    colorsList: widget.favColorsList,
                    handleColorDelete: widget.handleColorDelete,
                    handlelocalColorDelete: _deleteColorLocally,
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_outlined,
                            size: 18,
                          ),
                          SizedBox.square(
                            dimension: 5,
                          ),
                          Text('Press and hold a color to remove it.'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  ///also remove color in this widget
  void _deleteColorLocally(Color color) {
    setState(() {
      widget.favColorsList.remove(color);
    });
  }
}
