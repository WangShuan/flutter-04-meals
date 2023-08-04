# 使用 flutter 建構 Meals app

筆記連結：<https://hackmd.io/RcBJvZY-Sk-wKbDD4vFXoA?view>

該專案主要學習如何於多個屏幕之間切換並傳遞數據，比如在入口屏幕左上角的抽屜中，可點擊進入『所有食譜』及『篩選器』屏幕、底部的 tabs 欄位可於『所有類別』及『喜愛項目』屏幕之間切換、在所有類別屏幕中，可點擊分類進入『食譜列表』屏幕、在食譜列表屏幕中，可點擊食譜進入『食譜細節』屏幕。

## 新小部件速覽

- `InkWell` 小部件：
  - 讓小部件可以化身按鈕，於點擊時產生漣漪樣式
  - 可以綁定各種各樣的事件
- `Stack` 小部件：
  - 讓小部件之間可以上下堆疊
- `Positioned` 小部件：
  - 通常父層會搭配 `Stack` 小部件使用
  - 設定好上下左右的絕對定位數值以放置小部件在需要的位置
- `FadeInImage` 小部件：
  - 用來讓圖片產生載入的淡入淡出過場效果
  - 通常搭配 `transparent_image` 套件使用
- `Drawer` 小部件：
  - 是用來做抽屜的小部件，其子部件搭配 `DrawerHeader` 小部件使用
  - 放置在 `Scaffold` 小部件中，會在 `AppBar` 左側產生漢堡選單以開啟抽屜
- `ListTile` 小部件：
  - 生成帶有圖示、標題、副標題、事件綁定功能的精美小部件
  - 常作為 `ListView` 的子部件使用，但也可以單獨使用
- `BottomNavigationBar` 小部件：
  - 用來在屏幕下方做出 `tabs` 以切換屏幕
  - 其子部件搭配 `BottomNavigationBarItem` 小部件使用
- `GridView` 小部件：
  - 用來生成網格佈局，可設置一排幾個、上下間距、左右間距
- `Wrap` 小部件：
  - 用來讓小部件們可以在超過範圍時，自動換行排列
- `Hero` 小部件：
  - 製作過場動畫用的
  - 當兩個屏幕中出現相同小部件時，可用 `Hero` 小部件包裹，這樣在切換兩個屏幕時即可透過 `Hero` 小部件產生過場
- `WillPopScope` 小部件：
  - 處理離開頁面後要觸發的事件
  - 以本例來說，用來在用戶離開篩選器頁面時，可以正確傳遞與保存篩選狀態
- `SwitchListTile` 小部件：
  - 用來做出帶有 Switch 開關的 `ListTile` 小部件

## 定義 Category 與 Meal 的藍圖

以分類來說，需要有 `id` 辨識、 `title` 顯示名稱、 `color` 設定背景色，所以藍圖應該如下：

```dart
import 'package:flutter/material.dart';

class Category {
  const Category(this.id, this.title, this.color);

  final String id;
  final String title;
  final Color color; // 設置 color 類別為 Color，因 Color 是 material 提供所以需引入 material
}
```

以食譜來說，需要有 `id` 辨識、 `title` 顯示名稱、 `imgUrl` 呈現菜品、 `categories` 設置類別、 `ingredients` 顯示材料、 `steps` 顯示製作步驟、 `duration` 顯示製作時長、 `isGlutenFree` 判斷是否為無麩質飲食、 `isLactoseFree` 判斷是否為無乳糖食品、 `isVegan` 判斷是否為純素、 `isVegetarian` 判斷是否為蛋奶素，所以藍圖應該如下：

```dart
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
  final List<String> categories; // 屬於哪些分類
  final String imgUrl; // 圖片連結
  final List<String> ingredients; // 材料有哪些
  final List<String> steps; // 製作步驟依序是啥
  final String duration; // 製作時長
  final bool isGlutenFree; // 無麩質飲食
  final bool isLactoseFree; // 無乳糖食品
  final bool isVegan; // 素食（純素）
  final bool isVegetarian; // 蔬食（蛋奶素）
}
```

## 製作主屏幕

主屏幕需顯示所有類別，且需帶有抽屜開關讓用戶可進入篩選器屏幕、還需有底部的 tabs 欄位用來在所有類別及喜愛項目屏幕之間切換，建立 `tabs_screen.dart` 如下：

```dart
// 宣告 _activeIndex 用來保存當前選中的屏幕下標
int _activeIndex = 0;

Scaffold(
  appBar: AppBar(
    title: Text(_activeIndex == 0 ? '所有類別' : '喜好項目'), // 判斷下標以切換 title 內容
  ),
  drawer: MainDrawer(categories, selectedScreen), // 設置抽屜
  bottomNavigationBar: BottomNavigationBar( // 設置底部 tabs
    onTap: (index) { // 設置點擊時觸發的事件
      setState(() { // 保存當前選中的下標以切換顯示的屏幕
        _activeIndex = index;
      });
    },
    items: const [ // 設置 tabs 有哪些 tab 按鈕
      BottomNavigationBarItem( // 使用 BottomNavigationBarItem 小部件
        icon: Icon(Icons.category_rounded), // 設置圖標
        label: '所有類別', // 設置顯示標題
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: '喜好項目',
      ),
    ],
    currentIndex: _activeIndex, // 切換當前選中下標，以觸發樣式變動
    selectedItemColor: Theme.of(context).colorScheme.primary, // 設置選中的高亮顏色
  ),
  body: _activeIndex == 0 // 判斷選中下標以切換顯示的屏幕
      ? CategoriesScreen(filterMeals, toggleFavo)
      : MealsScreen('', _favoMeals, toggleFavo),
);
```

### 抽屜小部件

首先在 `tabs_screen.dart` 中宣告 `selectedScreen` (切換屏幕用的方法)，並將其傳給 `MainDrawer` 抽屜用的小部件：

```dart
// 宣告 selectedScreen 切換屏幕用的方法
void selectedScreen(String routeName) async {
  Navigator.of(context).pop(); // 關閉抽屜
  if (routeName == 'meals') { // 判斷點擊的是否為所有食譜
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen('所有食譜', meals, toggleFavo),
    ));
  }
}

// 把 selectedScreen 傳給 MainDrawer
drawer: MainDrawer(selectedScreen), 
```

接著在 `main_drawer.dart` 中設置抽屜小部件：

```dart
Drawer(
  child: Column(
    children: [
      DrawerHeader( // 設置 DrawerHeader 小部件顯示抽屜的標題
        child: Row(
          children: [
            Icon(Icons.restaurant),
            const SizedBox(width: 16),
            Text("Meals")
          ],
        ),
      ),
      ListTile( // 設置切換屏幕用的按鈕
        title: Text('所有食譜'),
        onTap: () { // 設置點擊事件
          selectedScreen('meals'); // 點擊後觸發切換屏幕事件
        },
      ),
      ListTile(
        title: Text('篩選器'),
        onTap: () {
          selectedScreen('filters');
        },
      )
    ],
  ),
);
```

## 在屏幕之間傳遞篩選器狀態

於 `tabs_screen.dart` 中獲取篩選器的篩選狀態：

```dart
void selectedScreen(String routeName) async {
  Navigator.of(context).pop();
  if (routeName == 'filters') {
    // 獲取 Navigator.of(context).push 回傳的內容
    final f = (await Navigator.of(context).push<Map<Filter, bool>>(
      MaterialPageRoute(
        builder: (context) => FiltersScreen(_selectedFilter),
      ),
    ))!;

    // 將 Navigator.of(context).push 回傳的篩選狀態保存起來
    setState(() {
      _selectedFilter = f;
    });
  } else {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen('所有食譜', meals, toggleFavo),
    ));
  }
}
```

於 `filters_screen.dart` 中通過 `WillPopScope` 傳遞篩選狀態到外層(`tabs_screen.dart`)：

```dart
WillPopScope(
  onWillPop: () async { // 通過 onWillPop 方法於關閉屏幕時觸發事件
    Navigator.of(context).pop({ // 關閉屏幕的同時傳遞數據
      Filter.glutenFree: _isGlutenFree,
      Filter.lactoseFree: _isLactoseFree,
      Filter.vegan: _isVegan,
      Filter.vegetarian: _isVegetarian,
    });
    return false; // 回傳 false 表示不要執行 pop()
  },
  child: Column(
    children: [
      SwitchListTile(),
      SwitchListTile(),
    ],
  ),
);
```

> 由於在 `onWillPop` 中已經通過 `Navigator.of(context).pop({...})` 傳遞篩選狀態了，所以最後要回傳 false 給 `onWillPop` 否則回傳 true 會導致多執行一次 pop() 事件，關閉整個應用。

接著在 `tabs_screen.dart` 中，宣告 `filterMeals` 保存篩選器過濾後的食譜，並傳遞給 `CategoriesScreen` ，再藉由 `CategoriesScreen` 傳遞給 `MealsScreen` 以顯示篩選後的食譜：

```dart
final List<Meal> filterMeals = meals.where((meal) {
  // 判斷當食譜的 isGlutenFree 為否，且 filter 開啟時不要加入該食譜
  if (!meal.isGlutenFree && _selectedFilter[Filter.glutenFree]!) {
    return false;
  }
  if (!meal.isLactoseFree && _selectedFilter[Filter.lactoseFree]!) {
    return false;
  }
  if (!meal.isVegan && _selectedFilter[Filter.vegan]!) {
    return false;
  }
  if (!meal.isVegetarian && _selectedFilter[Filter.vegetarian]!) {
    return false;
  }
  // 讓其他非上述判斷的食譜都加到 filterMeals 中
  return true;
}).toList(); // 最後轉為 List 類型

// 把 filterMeals 傳給 CategoriesScreen
CategoriesScreen(filterMeals, toggleFavo)
```

## 將食譜加入喜愛項目

在 `meal_screen.dart` 中點擊按鈕，觸發 `toggleFavo` 事件，該 `toggleFavo` 事件來自於外層的 `meals_screen.dart` ，而 `meals_screen.dart` 的事件則來自於外層的 `tabs_screen.dart`：

```dart
// 1. tabs_screen.dart
// 宣告 _favoMeals 用來存放喜愛項目
final List<Meal> _favoMeals = [];

// 設置 toggleFavo 事件用來切換是否加入喜愛項目
void toggleFavo(Meal meal) {
  if (_favoMeals.contains(meal)) { // 如果食譜已經在 _favoMeals 則移除
    setState(() {
      _favoMeals.remove(meal);
    });
    _showMessage('已將食譜${meal.title}從喜好項目中移除。');
  } else { // 如果食譜不存在 _favoMeals 則加入
    setState(() {
      _favoMeals.add(meal);
    });
    _showMessage('已將食譜${meal.title}添加到喜好項目中。');
  }
}

// 將 toggleFavo 方法傳給 MealsScreen
MealsScreen('', _favoMeals, toggleFavo)


// 2. meals_screen.dart
// 設置 _selectedMeal 事件，把 toggleFavo 傳給 MealScreen
void _selectedMeal(BuildContext context, Meal meal) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (ctx) => MealScreen(meal, toggleFavo),
  ));
}

// 3. meal_screen.dart
// 將 toggleFavo 作為按鈕點擊後觸發的事件
appBar: AppBar(
  title: Text(meal.title),
  actions: [
    IconButton(
        onPressed: () {
          toggleFavo(meal);
        },
        icon: const Icon(Icons.favorite_border))
  ],
)
```

## 其他新小部件用法

### InkWell 小部件做漣漪效果按鈕

要讓某個小部件可點擊並執行點擊事件可以使用 `InkWell` 小部件包裹，並設置其 `onTap` 事件：

```dart
InkWell(
  splashColor: Theme.of(context).primaryColor, // 設置點擊時漣漪的顏色
  borderRadius: BorderRadius.circular(8), // 設置圓角
  onTap: () {}, // 設置點擊後要觸發的事件
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),  // 設置與父層相同的圓角
    ),
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  ),
)
```

### 跳轉屏幕事件

點擊按鈕後跳轉到其他屏幕的做法：

```dart
// 1. 在分類的屏幕 CategoriesScreen 中設置跳轉到食譜屏幕 MealsScreen 的方法 _selectedCategory
void _selectedCategory(BuildContext context, Category category) {
  Navigator.of(context).push( // 通過 Navigator.of(context).push 跳轉屏幕，傳入 route
    MaterialPageRoute( // 使用 MaterialPageRoute 方法作為 route
      builder: (context) => MealsScreen(category, meals), // 傳入 builder，並傳入食譜屏幕 MealsScreen
    )
  );
}

// 2. 在分類的屏幕 CategoriesScreen 中，將 _selectedCategory 方法傳遞給每個分類子部件 CategoryGridItem
CategoryGridItem(
  c.title,
  c.color,
  () {
    // 由於需傳遞參數給 _selectedCategory 
    // 所以要用空函數包裹住 _selectedCategory
    // 否則會被 dart 誤以為要立即執行 _selectedCategory 函數
    _selectedCategory(context, c); 
  },
)

// 3. 在分類子部件 CategoryGridItem 中接收並使用 _selectedCategory 函數
final Function() selectedCategory; // 接收函數

InkWell(
  onTap: selectedCategory, // 傳入函數
  child: // ...
);
```

### FadeInImage 小部件處理圖片載入時的淡入淡出

可使用 FadeInImage 小部件將圖片包裹住，這樣在圖片加載時，即可顯示淡入淡出效果（這邊需安裝 transparent_image 套件，用於 FadeInImage 小部件的 placeholder）：

```dart
FadeInImage.memoryNetwork(
  placeholder: kTransparentImage, // 設置圖片載入前顯示的內容為 transparent_image 提供的 kTransparentImage
  image: meal.imgUrl,
  width: double.infinity, // 設置圖片寬度
  height: 300, // 設置圖片度
  fit: BoxFit.cover, // 設置圖片不符合寬高時要自動裁切填滿
)
```

### for loop 獲取 index 的方法

for loop 中可以通過以下做法獲取 index ：

```dart
for (final (index, step) in meal.steps.indexed)
  ListTile(
    leading: CircleAvatar(
      child: Text('${index + 1}', textAlign: TextAlign.center),
    ),
    title: Text(
      step,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
  ),
```

### Hero 小部件做兩個屏幕間的過場

可以用 Hero 小部件包裹住兩個屏幕之間重複的元素，以做出過場效果，以本例來說，可將 MealItem 中的圖片用 Hero 小部件包裹住，再將 MealScreen 中的圖片也用 Hero 小部件包裹住，這樣點擊 MealItem 中的圖片進入 MealScreen 時就可以看到圖片過場效果：

```dart
 Hero(
  tag: meal.id, // 在兩邊都傳入相同的辨識標記
  child: FadeInImage.memoryNetwork( // 兩邊都使用相同小部件
    placeholder: kTransparentImage,
    image: meal.imgUrl,
    width: double.infinity,
    height: 300,
    fit: BoxFit.cover,
  ),
),
```

### Stack & Positioned 小部件

```dart
Stack(
  alignment: Alignment.bottomRight, // 設置其 children 的對齊方式
  children: [ 
    Hero( // 設置一個圖片當底
      tag: meal.id,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: meal.imgUrl,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
      ),
    ),
    Positioned( // 設置一個標籤，用 Positioned 規定要放在右 0 下 8 處
      bottom: 8,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 16),
        child: MealItemLable(
            const Icon(Icons.schedule), meal.duration),
      ),
    ),
  ],
)
```

### Wrap 讓文字超過寬度自動換行

```dart
Wrap(
  alignment: WrapAlignment.center, // 設置內容對齊方式
  children: [ // 放入所有食譜的材料
    for (final e in meal.ingredients)
      Text(
        meal.ingredients.last == e ? e : '$e、',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      )
  ],
)
```

### SwitchListTile 開關小部件

```dart
SwitchListTile(
  title: Text( // 設置標題
    '不含乳糖',
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
  ),
  subtitle: Text( // 設置副標題
    '篩選所有不含乳糖的食譜',
    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
  ),
  activeColor: Theme.of(context).colorScheme.primary, // 設置開啟時的高亮顏色
  value: _isLactoseFree, // 設置預設的 value 為 _isLactoseFree
  onChanged: (value) { // 開關切換時觸發
    setState(() { // 更新 _isLactoseFree 的值
      _isLactoseFree = value;
    });
  },
),
```

### GridView 小部件

```dart
GridView(
  padding: const EdgeInsets.all(20), // 設置最外面的間距
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // 設置一行幾個
    childAspectRatio: 1.75, // 設置單個的寬高比
    crossAxisSpacing: 20, // 設置水平間距
    mainAxisSpacing: 20, // 設置垂直間距
  ),
  children: [
    for (final c in categories)
      CategoryGridItem(
        c.title,
        c.color,
        () {
          _selectedCategory(context, c);
        },
      )
  ],
);
```

- gridDelegate
  - 如果是 SliverGridDelegateWithMaxCrossAxisExtent ，則需設置 `maxCrossAxisExtent` 限制每個子部件可用的最大寬度
  - 如果是 SliverGridDelegateWithFixedCrossAxisCount ，則需設置 `crossAxisCount` 限制每行要放給多少個子部件均分

### ListTile 小部件

```dart
for (final (index, e) in meal.steps.indexed)
  ListTile(
    leading: CircleAvatar( // leading 設置圖標，用 CircleAvatar 設置圓形填色背景
      child: Text('${index + 1}'), // 顯示步驟數
    ),
    title: Text(e), // 顯示步驟內容
  )
```

- leading 設置左側圖標，常見放圓形填色背景、頭貼圖片、Icon 等等
- title 設置主要標題
- subtitle 設置次要標題，會顯示在標題下方，比標題小字
- trailing 設置右側圖標，常見放箭頭 Icon 按鈕等等
