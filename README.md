# New Edok


## Запуск проекта 
 Для первого запуска проетка необходимо запустить когогенерацию через build_runner
 Сначала стоит прочитать что это вообще за штука такая и как с ней работать
 Необходимо добавить flutter в пеменную среды и запустить с терминала следующую команду -->
 "flutter packages pub run build_runner build --delete-conflicting-outputs"  


## Git ignore 
  Тут прописаны файлы с расширением: 
     *.g.dart
     *.gr.dart
     *.freezed.dart
     *.iconfig.dart
 
  Так как они генерируются через build_runner

## Генерация 
  Модели для каждого компонента генерируются автоматически
  
## Начало работы
   Перед началом работы с проектом лучше взглянуть на связку CitiesModel + CitiesStore
   Все файлы храняться в модели и стор файле, для каждоый модели свой стор файл 
 
## HTTP Запросы
   Все запросы проимходят с помощью библиотеки Dio, так как запросы будут генерироваться вместе с запуском кодогенерации, запросы выполняются с помощию метода и названия запроса
   Так же советую ознакомиться с библеотекой mobx
## Принты
   Многие данные выводятся через logger так как они стабильнее, и в идеале не рекомендуется использовать принт так как он теряется в потоке данных, но если необходимо проверить какие-то данные, то можно использовать принты, но после редактирования необходимо удалять принты для поддержки частоты кода
   
## Частота кода 
   После каждой дорабодки в обязательном порядке нужно проверять Dart Analysis и удалять все принты
   
## Темы
   Все цвета и стили текста хранятся в папке themes и  использутся вызовом команды Thm.of(context).и тут указываем парамтр текста. С цветами так же Thm.of(context).параметр цвета. Это сделано с целью правильный и аккуратной версти всех компонентов
   
