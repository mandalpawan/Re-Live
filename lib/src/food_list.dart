import 'package:flutter/material.dart';
import 'package:food_delivery/page/frequently_bought.dart';
import 'package:food_delivery/src/food_api.dart';
import 'package:food_delivery/src/food_notifier.dart';
import 'package:provider/provider.dart';

class Bought_item extends StatefulWidget {
  @override
  _Bought_itemState createState() => _Bought_itemState();
}

class _Bought_itemState extends State<Bought_item> {
  @override

  @override
  void initState() {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context,listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  Widget build(BuildContext context) {

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context,int index){
        return GestureDetector(
            onTap: () {
              foodNotifier.currentFood = foodNotifier.foodList[index];
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return frequentlyBought();
                  }
                  )
              );
            },
          child: Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Column(
                children: [
                  Container(
                    height: 200.0,
                    width: 350.0,
                    child: Image.network(
                      foodNotifier.foodList[index].image != null ?
                      foodNotifier.foodList[index].image : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foodNotifier.foodList[index].title,
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Price",
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "Rs. " + foodNotifier.foodList[index].price,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

      separatorBuilder: (BuildContext context,int index){
        return Divider(
          height: 0.0,
        );
      },
      itemCount: foodNotifier.foodList.length,
    );
  }
}
