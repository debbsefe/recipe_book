import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/ingredient_model.dart';
import 'package:recipe_book/screens/recipe_details.dart';
import 'package:recipe_book/services/getApi.dart';

class RelatedSearch extends StatelessWidget {
  final String ingredient;
  final List<Recipe> recipes;

  RelatedSearch({this.ingredient, this.recipes});

  GetApi _getApi = new GetApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {}),
        backgroundColor: Colors.transparent,
        title: Text(
          'Search Result',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<IngredientModel>(
        future: _getApi.getIngredients(ingredient),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Hits> list = snapshot.data.hits;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  print("Im here");
                  return Text(list[index].bookmarked.toString());
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget makeItem({image, tag, context}) {
    return Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeDetails(
                          image: image,
                        )));
          },
          child: Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      'Tomatoes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
