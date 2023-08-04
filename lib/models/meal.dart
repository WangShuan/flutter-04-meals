class Meal {
  const Meal({
    required this.id,
    required this.title,
    required this.categories,
    required this.imgUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final String title;
  final List<String> categories; // 分類
  final String imgUrl; // 圖片
  final List<String> ingredients; // 材料
  final List<String> steps; // 製作步驟
  final String duration; // 製作時長
  final bool isGlutenFree; // 無麩質飲食（戒澱粉概念）
  final bool isLactoseFree; // 無乳糖食品
  final bool isVegan; // 素食（純素）
  final bool isVegetarian; // 蔬食（蛋奶素概念）
}
