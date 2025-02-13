enum MenuType {
  mainCourse,
  dessert,
  beverage,
  fruit
}

class MainMenu {
  const MainMenu({
    required this.idMain,
    required this.categoriesMain,
    required this.titleMain,
    required this.imageUrlMain,
    required this.calorieMain,
    required this.menuType, 
  });

  final String idMain;
  final List<String> categoriesMain; 
  final String titleMain; 
  final String imageUrlMain; 
  final String calorieMain; 
  final MenuType menuType; 
}
