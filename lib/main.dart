import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cafe/constants.dart';
import 'package:cafe/details_screen.dart';
import 'package:cafe/widgets/category_title.dart';
import 'package:cafe/widgets/food_card.dart';
import 'Auth/Auth.dart';
import 'Auth/login_page.dart';
import 'Auth/new_auth.dart';
import 'login_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
          fontFamily: "Poppins",
          scaffoldBackgroundColor: kWhiteColor,
          primaryColor: kPrimaryColor,
          textTheme: const TextTheme(
            headline1: TextStyle(fontWeight: FontWeight.bold),
            button: TextStyle(fontWeight: FontWeight.bold),
            subtitle1: TextStyle(fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: kTextColor),
          )),
      home: const LoginScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeCategoryTitle = 'Все';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('food').add({
            'title': '',
            'ingredient': '',
            'image': 'assets/images/image_1_big.png',
            'price': 0,
            'calories': '',
            'description': '',
            'category': '',
          });
        },
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: rowHeight * 1.5,
                child: Image.asset(
                  'assets/images/LaCaramell.png',
                  fit: BoxFit.fitHeight,
                ),
              ),),

            SizedBox(
              height: rowHeight * 1.5,
              width: rowHeight * 1.5,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(0,35,75,0),
                splashColor: Colors.black,
                focusColor: Colors.black,
                iconSize: rowHeight,
                icon: const Icon(Icons.account_circle,
                color: Colors.black38),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const LoginScreen() /*AuthPageNew(title: 'Личные данные')*/));
                },
              ),
            )
            ],
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Все';
                      setState(() {});
                    },
                    child: Text(
                      "Все",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Все")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Завтраки';
                      setState(() {});
                    },
                    child: Text(
                      "Завтраки",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Завтраки")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Бизнес-ланчи';
                      setState(() {});
                    },
                    child: Text(
                      "Бизнес-ланчи",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Бизнес-ланчи")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Пицца';
                      setState(() {});
                    },
                    child: Text(
                      "Пицца",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Пицца")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Закуски';
                      setState(() {});
                    },
                    child: Text(
                      "Закуски",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Закуски")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: categoryButtonStyle,
                    onPressed: () {
                      activeCategoryTitle = 'Салаты';
                      setState(() {});
                    },
                    child: Text(
                      "Салаты",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: (activeCategoryTitle == "Салаты")
                                ? kPrimaryColor
                                : kTextColor.withOpacity(.4),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child:
          Expanded(
            // child: RefreshIndicator(
            //   onRefresh: pullRefresh,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('food').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  //int number = 0;
                  if (snapshot.hasError) {
                    return const Text('Что-то пошло не так');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      // number++;
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Column(children: [
                        SizedBox(
                          height: (data['category'] == activeCategoryTitle ||
                                  activeCategoryTitle == 'Все')
                              ? rowHeight * 10
                              : 0,
                          child: FoodCard(
                            press: () {
                              //  Navigator.push(
                              //    context,
                              // //   MaterialPageRoute(builder: (context) {
                              //     return DetailsScreen();
                              //    }),
                              //   );
                            },
                            title: data['title'],
                            image: data['image'],
                            price: data['price'],
                            calories: data['calories'],
                            description: data['description'],
                            ingredient: data['ingredient'],
                            category: data['category'],
                          ),
                        ),
                      ]);
                    }).toList(),
                  );
                }),
          ),

          /* SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height:(activeCategoryTitle=='Все' || activeCategoryTitle == 'Завтраки')?400:0,
                    child: FoodCard(
                      press: () {
                        //  Navigator.push(
                        //    context,
                        // //   MaterialPageRoute(builder: (context) {
                        //     return DetailsScreen();
                        //    }),
                        //   );
                      },
                      title: "Вегетарианский салат",
                      image: "assets/images/image_1.png",
                      price: 350,
                      calories: "420 Ккал/100 г",
                      description: "Очень популярный салат ",
                      ingredient: 'Морковь, томаты, лимоны, сельдерей',
                      category: 'Завтраки',
                    ),
                  ),
                  SizedBox(
                    height:(activeCategoryTitle=='Все' || activeCategoryTitle == 'Салаты')?400:0,
                    child: FoodCard(
                      press: () {},
                      title: "Тарелка салата",
                      image: "assets/images/image_2.png",
                      price: 200,
                      calories: "390 Ккал/100г",
                      description: "Листья салата для отбитых веганов ",
                      ingredient: 'Листья салата',
                      category: 'Салаты',
                    ),
                  ),
                  SizedBox(width: 20),

                ],
              ),
            ),*/
          // ),
        ],
      ),
    );
  }
}
