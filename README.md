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
