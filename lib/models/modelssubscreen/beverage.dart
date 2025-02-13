enum MenuType {
  mainCourse,
  dessert,
  beverage,
  fruit,
}

class Beverage {
  const Beverage({
    required this.idWater,
    required this.categoriesWater,
    required this.titleWater,
    required this.imageUrlWater,
    required this.calorieWater,
    required this.menuType, 
  });

  final String idWater;
  final List<String> categoriesWater; 
  final String titleWater; 
  final String imageUrlWater; 
  final String calorieWater; 
  final MenuType menuType; 
}
