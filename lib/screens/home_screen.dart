import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solid_task_project/widgets/home_drawer.dart';

///material app body home
class HomeScreen extends StatefulWidget {
  /// constructor
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  //favorite colors
  final List<Color> _favColors = [];
  //list of texts to display
  final List<String> _textToDisplayList = [
    'Hello there.', //welcome text not to be repeated
    'The color changed!', //first change text not to be repeated
    'Another one!',
    'This color is great',
    'I like this one...',
    "I've always loved this tone.",
    'Amazing.',
    'i think this one is my favorite',
    'Wow',
    'Empowering.',
    'Classic.',
    'What a shade!',
    'Uplifting.',
    'Nice one!',
    'Ah... colors',
    'Interesting...',
    'Good one.',
    'Inspiring',
    'Gives me some ideas',
    'Captivating.'
  ];
  late final String _welcomeText;
  final _randomGenerator = Random();
  Color _currentBGColor = const Color.fromARGB(255, 36, 2, 53);
  late String _currentText;
  final List<String> _recentDisplayedTextList = [];
  bool _displayFavorited = false;

  ///delete color from fav list
  void colorDelete(Color color) {
    setState(() {
      _favColors.remove(color);
      _setFavorited();
    });
  }

  ///determine if a black or white text is better suited
  Color calculateTextColor(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.light
        ? Colors.black
        : Colors.white;
  }

  //manages text to be displayed on screen making sure
  //it isn't that repetitive
  void _changeTextToDisplay() {
    int randomPositionNumber;
    const int maxLength = 5;

    if (_welcomeText == _currentText) {
      //display second text
      _currentText = _textToDisplayList[1];
      //get rid of texts i dont want repeated
      _textToDisplayList.removeRange(0, 2);
      return;
    }
    //add current text to my recently displayed text lists
    _recentDisplayedTextList.add(_currentText);
    //assign a new random text
    do {
      randomPositionNumber =
          _randomGenerator.nextInt(_textToDisplayList.length - 1);
      _currentText = _textToDisplayList[randomPositionNumber];
    } while (_recentDisplayedTextList.contains(_currentText));

    //recently displayed texts cleanup
    if (_recentDisplayedTextList.length > maxLength) {
      _recentDisplayedTextList.removeAt(0);
    }
  }

  //change current bg color
  void _changeBGColor() {
    final auxVar = _randomGenerator.nextInt(255);
    final a = auxVar < (255 - 80) ? auxVar + 80 : auxVar;
    final r = _randomGenerator.nextInt(255);
    final g = _randomGenerator.nextInt(255);
    final b = _randomGenerator.nextInt(255);
    _currentBGColor = Color.fromARGB(a, r, g, b);

    _setFavorited();
  }

  ///check if favorite then set accordingly
  void _setFavorited() {
    _favColors.contains(_currentBGColor)
        ? _displayFavorited = true
        : _displayFavorited = false;
  }

  void _updateWidgetState() {
    setState(() {
      _changeBGColor();
      _changeTextToDisplay();
    });
  }

  void _toggleFavorite(Color value) {
    setState(() {
      _displayFavorited = !_displayFavorited;
    });
    _favColors.contains(value)
        ? _favColors.remove(value)
        : _favColors.add(value);
  }

  @override
  void initState() {
    super.initState();
    //initialize the welcome text
    _recentDisplayedTextList
        .add(_currentText = _welcomeText = _textToDisplayList.first);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solid Test App'),
        ),
        drawer: HomeDrawer(favColorsList: _favColors, colorDelete: colorDelete),
        floatingActionButton: Visibility(
          visible: _currentText != _welcomeText,
          child: FloatingActionButton(
            onPressed: () => _toggleFavorite(_currentBGColor),
            elevation: 6,
            child: AnimatedSwitcher(
              switchOutCurve: Curves.bounceOut,
              duration: const Duration(milliseconds: 300),
              child: _displayFavorited
                  ? const Icon(key: ValueKey('fav'), Icons.favorite)
                  : const Icon(key: ValueKey('notFav'), Icons.favorite_border),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: _updateWidgetState,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: ColoredBox(
              key: UniqueKey(),
              color: _currentBGColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _currentText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: calculateTextColor(_currentBGColor),
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
