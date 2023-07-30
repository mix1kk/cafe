import 'package:flutter/material.dart';
import 'package:cafe/constants.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String ingredient;
  final String image;
  final int price;
  final String calories;
  final String description;
  final Function press;
  final String category;

  const FoodCard({
   // required Key key,
    required this.title,
    required this.ingredient,
    required this.image,
    required this.price,
    required this.calories,
    required this.description,
    required this.press,
    required this.category
  }); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        height: 400,
        width: 270,
        child: Stack(
          children: <Widget>[
            // Big light background
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 380,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  color: kPrimaryColor.withOpacity(.06),
                ),
              ),
            ),
            Positioned(
              top: 25.0,
              left: 0,
              child: Container(
                height: 184,
                width: 276,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),),
                child: Image.network(image, fit:BoxFit.fitHeight, ),
                // decoration: BoxDecoration(
                //   image:
                //   DecorationImage(
                //     image: 
                //     AssetImage(image),
                //   ),
                // ),
              ),
            ),
            // Price
            Positioned(
              right: 20,
              top: 340,
              child: Text(
                "$price руб.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: kPrimaryColor),
              ),
            ),
            Positioned(
              top: 211,
              left: 40,
              child: Container(
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Состав: $ingredient",
                      style: TextStyle(
                        color: kTextColor.withOpacity(.4),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      description,
                      maxLines: 3,
                      style: TextStyle(
                        color: kTextColor.withOpacity(.65),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      calories,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
