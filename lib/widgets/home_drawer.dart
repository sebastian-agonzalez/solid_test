import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solid_task_project/screens/favorites_screen.dart';

///Drawer for the Home Screen
class HomeDrawer extends StatelessWidget {
  ///list of fasvorite colors
  final List<Color> favColorsList;

  ///callback f
  final void Function(Color) colorDelete;

  ///constructor
  const HomeDrawer({
    super.key,
    required this.favColorsList,
    required this.colorDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 35, 20, 62),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                Timer(
                  const Duration(milliseconds: 250),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FavoritesScreen(
                            favColorsList: favColorsList,
                            handleColorDelete: colorDelete,
                          );
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(
                          milliseconds: 300,
                        ),
                      ),
                    );
                  },
                );
              },
              leading: Icon(
                Icons.favorite,
                size: 26,
                color: Colors.red.shade400,
              ),
              title: const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
