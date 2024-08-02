import 'package:flutter/material.dart';
import 'package:recipe/recipe.dart';
import 'package:recipe/recipe_detail.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  // 1
  @override
  Widget build(BuildContext context) {
// 2
    final ThemeData theme = ThemeData();
    // 3
    return MaterialApp(
// 4
      title: 'Recipe Calculator',
      // 5
      theme: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
        ),
      ),
// 6
      home: const MyHomePage(
        title: 'Recipe Calculator',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
// 1
    return Scaffold(
      // 2
      appBar: AppBar(
        title: Text(widget.title),
      ),
// 3
      body: SafeArea(
        // 4
        //ListView build a list
        child: ListView.builder(
          itemCount: Recipe.samples.length,
          //itemCount determines the number of rows that the list has. In this case, rows=6(length=number of objects in the Recipe.samples list)
          itemBuilder: (context, index) {
            //itemBuilder builds the widget tree for each row(it build based on index)
            //GestureDetector detects 'gestures'
            return GestureDetector(
              // the 'onTap()' function is a callback when the widget is tapped
              onTap: () {
                // the Navigator widget manages a stack of pages.
                //by calling 'push()' with a MaterialpageRoute will push a new Materail page onto the stack.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder creates the destination page widget
                    builder: (ctx) => RecipeDetail(
                      recipe: Recipe.samples[index],
                    ),
                  ),
                );
              },
              //GestureDetector child widget defines the area where the gesture is active
              child: buildCustomRecipeCard(Recipe.samples[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildCustomRecipeCard(Recipe recipe) {
    return Card(
      //elevation adds a nice shadow behind
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                recipe.imageUrl,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              recipe.label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
