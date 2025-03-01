import 'package:beta_eats/model/foodmodel.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int totalprice = 0;
  List<Food> foodd = CartList;
  final snackBar2 = const SnackBar(
      content: Text("Removed from Cart"),
      duration: Duration(milliseconds: 200));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: buildFoods(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Total: $totalprice',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  List<Widget> buildFoods() {
    List<Widget> list = [
      const SizedBox(height: 20),
    ];
    totalprice = 0;
    for (var i = 0; i < foodd.length; i++) {
      list.add(
          Hero(tag: foodd[i].image ?? '', child: foodProperty(foodd[i], i)));

      totalprice += foodd[i].price!;
      setState(() {});
    }
    return list;
  }

  Widget foodProperty(Food food, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: food.image != null
                  ? Image.asset(
                      food.image!,
                      fit: BoxFit.cover,
                    ).image
                  : Image.network('').image,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        food.name!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          backgroundColor: Colors.white54,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Price: ${food.price!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          backgroundColor: Colors.white54,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.shopping_cart, color: Colors.black54),
                    onPressed: () {
                      if (foodd.contains(food)) {
                        Foodpro().removefromcartlist(food);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                      } else {
                        Foodpro().addtocartlist(food);
                      }

                      setState(() {});
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
