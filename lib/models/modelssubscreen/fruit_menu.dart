enum MenuType {
  mainCourse,
  dessert,
  beverage,
  fruit
}

class FruitMenu {
  const FruitMenu({
    required this.idFruit,
    required this.categoriesFruit,
    required this.titleFruit,
    required this.imageUrlFruit,
    required this.calorieFruit,
    required this.menuType, 
  });

  final String idFruit;
  final List<String> categoriesFruit; 
  final String titleFruit; 
  final String imageUrlFruit; 
  final String calorieFruit; 
  final MenuType menuType; 
}
