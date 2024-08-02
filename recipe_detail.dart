import 'package:flutter/material.dart';
import 'package:recipe/recipe.dart';

/*class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key);
@override
  State<RecipeDetail> createState() {
    return _RecipeDetailState();
  }
}*/

// This contructor definition is the same as below, BUT below is DA WAY to do it

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeDetail> createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVar = 1;

  @override
  Widget build(BuildContext context) {
    //Scaffold defines the page's general structure
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      //SafeArea keeps the app from getting too close to the operating system interfaces, such as the notch or the interactive area of most iPhones.
      body: SafeArea(
        child: Column(
          children: [
            //by putting the SizedBox around an image, I define resizable bounds for the image. In this case, the height is fixed at 300, but the width will adjust to fit the aspect ratio
            //The unit of measurement in FLutter is logical pixels.
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.recipe.imageUrl),
              ),
            ),
            //This SizedBox() is used as a spacer
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.recipe.label,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            //the Expanded() widget expands to fill the space in a Column. This way, the ingredient list will take up the space not filled by the other widgets.
            Expanded(
              //a ListView, with one row per ingredient
              child: ListView.builder(
                padding: const EdgeInsets.all(
                  7,
                ),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (
                  ctx,
                  index,
                ) {
                  final ingredient = widget.recipe.ingredients[index];
                  return Text(
                      //A Text that uses string interpolation to populate a string with runtime values.
                      //You use the ${expression} syntax inside the string literal to denote these.
                      '${ingredient.quantity * _sliderVar}  ${ingredient.measure}  ${ingredient.name}');
                },
              ),
            ),
            Slider(
              //min, max and divisions define how the slider moves. Here, it moves between the values of 1 and 10, with ten discret stops
              //So it can have values of 1,2,...,10
              min: 1,
              max: 10,
              divisions: 9,
              //label updates as the _slideVar changes and displays a scaled number of servings
              label: '${_sliderVar * widget.recipe.servings} servings',
              //the Slider works in double values, so here I convert the int variable
              value: _sliderVar.toDouble(),
              //Conversely, when the slider changes, this uses round() to convert the double slider value to an int, then saves it in _sliderVal.
              onChanged: (newValue) {
                setState(() {
                  _sliderVar = newValue.round();
                });
              },
              //This sets the slider’s colors to something more “on brand”. The activeColor is the section between the minimum value and the thumb, and the inactiveColor represents the rest.
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
