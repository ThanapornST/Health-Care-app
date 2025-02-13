enum MenuType {
  mainCourse,
  dessert,
  beverage,
  fruit,
}

class DessertMenu {
  const DessertMenu({
    required this.iddessert,
    required this.categoriesdessert,
    required this.titledessert,
    required this.imageUrldessert,
    required this.caloriedessert,
    required this.menuType,
  });

  final String iddessert;
  final List<String> categoriesdessert;
  final String titledessert;
  final String imageUrldessert;
  final String caloriedessert;
  final MenuType menuType;
}
