import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';

const categories = [
  Category(
    'c1',
    '飯類主食',
    Colors.pinkAccent,
  ),
  Category(
    'c2',
    '麵類主食',
    Colors.deepOrange,
  ),
  Category(
    'c3',
    '輕食沙拉',
    Colors.amber,
  ),
  Category(
    'c4',
    '果汁系列',
    Colors.green,
  ),
  Category(
    'c5',
    '早餐系列',
    Colors.indigo,
  ),
  Category(
    'c6',
    '減脂推薦',
    Colors.purple,
  ),
  Category(
    'c7',
    '黑暗料理',
    Colors.grey,
  ),
];

const meals = [
  Meal(
    id: 'm1',
    title: '鯖魚筍湯麵',
    categories: ['c2'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2019/11/19/18/34/food-4638227_1280.jpg',
    ingredients: [
      '茄汁鯖魚罐頭',
      '香筍罐頭',
      '任意種類的麵條',
      '任何你想吃的蔬菜',
    ],
    steps: [
      '將蔬菜洗淨切好備用',
      '於鍋中倒入五～六分滿的飲用水',
      '加入鯖魚罐頭及香筍罐頭',
      '開中大火煮到水滾後，加入麵條',
      '轉中小火，視麵條種類煮約三～五分鐘',
      '待麵條軟度可食用後，加入蔬菜',
      '蔬菜熟後即可關火上桌'
    ],
    duration: '15分鐘',
    isGlutenFree: false,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm2',
    title: '蔬菜鮪魚粥',
    categories: ['c1', 'c6'],
    imgUrl:
        'https://d189djjbmcrkk.cloudfront.net/tinymce/ysFXWkBtuxewWJcb3OamITqjoJm5wIj0AERVxsva.jpeg',
    ingredients: [
      '鮪魚罐頭',
      '玉米筍一盒',
      '一杯米',
      '花椰菜半顆',
      '飲用水',
    ],
    steps: [
      '將玉米筍及花椰菜洗淨切好備用',
      '將米倒入電子鍋中，加入三～四杯飲用水',
      '加入鮪魚罐頭及切好的蔬菜',
      '外鍋放一杯半水蒸煮',
      '電鍋跳起後，悶五分鐘即可上桌',
    ],
    duration: '10分鐘',
    isGlutenFree: false,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm3',
    title: '紅醬牛奶',
    categories: ['c7', 'c4'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2018/02/23/16/58/milk-3176015_1280.jpg',
    ingredients: [
      '草莓果醬少許',
      '紅蘿蔔四分之一條',
      '奶粉或牛奶適量',
      '半顆芭樂',
    ],
    steps: [
      '將紅蘿蔔與芭樂洗淨切好放入杯中',
      '加入一～兩湯匙草莓果醬',
      '加入兩匙奶粉或半蓋過材料的牛奶',
      '上蓋榨好後即可飲用',
    ],
    duration: '3分鐘',
    isGlutenFree: true,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: true,
  ),
  Meal(
    id: 'm4',
    title: '綠果汁',
    categories: ['c4'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2015/07/19/22/37/bottle-852133_1280.jpg',
    ingredients: [
      '任意三種或以上的綠色蔬果',
      '飲用水',
    ],
    steps: [
      '將綠色的水果及蔬菜切好備用',
      '把切好的蔬果放入杯中約七分滿',
      '加入半蓋過食材的飲用水',
      '上蓋榨好後即可飲用',
    ],
    duration: '5分鐘',
    isGlutenFree: true,
    isLactoseFree: true,
    isVegan: true,
    isVegetarian: true,
  ),
  Meal(
    id: 'm5',
    title: '洋蔥鮪魚沙拉',
    categories: ['c3', 'c6'],
    imgUrl:
        'https://cdn.cybassets.com/s/files/9949/ckeditor/pictures/content_b5149357-fd33-4cec-98a9-3714050d281b.jpg',
    ingredients: [
      '水煮鮪魚罐頭',
      '洋蔥一顆',
      '冰塊',
      '醬油適量',
    ],
    steps: [
      '將洋蔥洗淨，逆紋切好放入碗中',
      '用飲用水來回沖洗洋蔥三次，去除辛辣味',
      '放入冰塊及飲用水淹過洋蔥浸泡十五分鐘',
      '加入鮪魚罐頭及調味用的適量醬油',
      '攪拌均勻後即可食用'
    ],
    duration: '30分鐘',
    isGlutenFree: true,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm6',
    title: '泡菜豆腐鍋',
    categories: ['c6'],
    imgUrl:
        'https://cdn.ready-market.com/106/3d1b21f4//Templates/pic/Kimchi%20Tofu%20Hot%20Pot.jpg?v=172c5bc3',
    ingredients: [
      '愛之味泡菜兩罐',
      '嫩豆腐一盒',
      '任意火鍋肉片',
      '任何你想吃的蔬菜',
    ],
    steps: [
      '將蔬菜洗淨切好備用',
      '往鍋裡倒入兩罐泡菜罐頭',
      '用泡菜罐頭裝三～四罐飲用水加入鍋中',
      '開中小火，加入切好的豆腐',
      '水滾後加入火鍋肉片',
      '待肉片快熟時，加入切好的蔬菜',
      '蔬菜熟後即可關火上桌'
    ],
    duration: '7分鐘',
    isGlutenFree: true,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm7',
    title: '木瓜牛奶冰沙',
    categories: ['c4'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2017/03/31/16/07/smoothie-2191709_1280.jpg',
    ingredients: [
      '木瓜',
      '牛奶',
      '冰塊',
    ],
    steps: [
      '木瓜切好備用',
      '將切好的木瓜放入杯中約四分滿',
      '加入半蓋過食材的牛奶及冰塊',
      '上蓋榨好後即可飲用',
    ],
    duration: '3分鐘',
    isGlutenFree: true,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: true,
  ),
  Meal(
    id: 'm8',
    title: '綜合果汁',
    categories: ['c4'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2020/03/20/16/48/smoothies-4951253_1280.jpg',
    ingredients: [
      '超商或超市賣的綜合水果一盒',
    ],
    steps: [
      '將綜合水果依序放入杯中',
      '加入半蓋過材料的飲用水',
      '上蓋榨好後即可飲用',
    ],
    duration: '1分鐘',
    isGlutenFree: true,
    isLactoseFree: true,
    isVegan: true,
    isVegetarian: true,
  ),
  Meal(
    id: 'm9',
    title: '午餐肉夾蛋土司',
    categories: ['c5'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2016/11/18/19/00/bread-1836411_1280.jpg',
    ingredients: [
      '午餐肉罐頭',
      '蛋一顆',
      '牛番茄',
      '小黃瓜或生菜',
    ],
    steps: [
      '將午餐肉、番茄、小黃瓜切片備用',
      '將適量小黃瓜、兩片牛番茄放到吐司上',
      '熱鍋下油，煎午餐肉至金黃色、煎蛋',
      '將午餐肉放在番茄上、蛋放最上面，即可食用'
    ],
    duration: '5分鐘',
    isGlutenFree: false,
    isLactoseFree: true,
    isVegan: false,
    isVegetarian: false,
  ),
  Meal(
    id: 'm10',
    title: '莓果優格麥片',
    categories: ['c5'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2016/11/21/15/53/berries-1846085_1280.jpg',
    ingredients: [
      '草莓',
      '藍莓',
      '葡萄或葡萄乾',
      '燕麥片',
      '優格',
    ],
    steps: [
      '在碗中倒入燕麥片、葡萄乾及優格攪拌',
      '鋪上藍莓、草莓、葡萄即可食用',
    ],
    duration: '2分鐘',
    isGlutenFree: true,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: true,
  ),
  Meal(
    id: 'm11',
    title: '白醬義大利麵',
    categories: ['c2'],
    imgUrl:
        'https://cdn.pixabay.com/photo/2015/04/06/13/28/spaghetti-709337_1280.jpg',
    ingredients: [
      '康寶濃湯四人份一包',
      '飲用水',
      '鹽巴',
      '義大利麵',
      '任意喜歡的肉類主食',
    ],
    steps: [
      '在卓中加入適量鹽巴主義大利麵條',
      '用另外一鍋倒入康寶濃湯加適量飲用水攪拌至濃稠',
      '加入切好的肉類一起攪拌',
      '在碗中放入煮好的義大利麵條',
      '倒入煮好的醬料即可食用'
    ],
    duration: '12分鐘',
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
  ),
];
