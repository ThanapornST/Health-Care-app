

import 'package:appfinal/models/meal.dart';

const dummyMeals = [
  Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Main menu',
    menuType: MenuType.mainCourse, 
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
  ),
  Meal(
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'Fruit',
    menuType: MenuType.mainCourse, 
    imageUrl:
        'https://www.sentangsedtee.com/wp-content/uploads/2024/07/410310460_17952658382707325_8396411631213153984_n-1024x1024.jpg',
    
  ),
  Meal(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Dessert Menu',
    menuType: MenuType.mainCourse, 
    imageUrl:
        'https://cms.dmpcdn.com/travel/2017/06/28/7888c3b0-0b22-499f-8554-66cef560ada5.jpg',
  ),
  Meal(
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Beverage',
    menuType: MenuType.mainCourse, 
    imageUrl:
        'https://today-obs.line-scdn.net/0huJCoWe23KmV-FgNYDx5VMkRAKQpNejlmGiB7ZiJ4dFEEIj01EHQyUFIUI1xXI207EHhnBlIWMVQBLmpjQHUy/w644',
  ),
];

