enum MenuType {
  mainCourse,
  fruit,
  dessertMenu,
  drinkingWater,
}

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.menuType,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final MenuType menuType;
}
