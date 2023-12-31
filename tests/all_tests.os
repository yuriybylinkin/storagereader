#Использовать asserts
#Использовать ".."

Перем ПутьКХранилищу1;
Перем ПутьКХранилищу2;
Перем ПутьКВыгрузкеКонфигурации;

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт

    ВсеТесты = Новый Массив;    
    ВсеТесты.Добавить("ТестДолжен_ПроверитьПолучениеТаблицыЗахватовВХранилище");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьПолучениеТаблицыЗахватовВХранилищеСВыгрузкойИсходногоКода");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьПолучениеИнформацииОЗахватеКорня");
	
    Возврат ВсеТесты;

КонецФункции

Процедура ТестДолжен_ПроверитьПолучениеТаблицыЗахватовВХранилище() Экспорт

	ЧтениеХранилища = Новый ЧтениеХранилища(ПутьКХранилищу1);
	ЧтениеХранилища.ПрочитатьХранилище();	

	ТаблицаЗахватов = ЧтениеХранилища.ТаблицаЗахватов();
	
	Ожидаем.Что(ТаблицаЗахватов.Количество(), 
				"Количество захваченных объектов в хранилище 1").Равно(4);

	ПерваяСтрокаТаблицы = ТаблицаЗахватов[0];
	Ожидаем.Что(ПерваяСтрокаТаблицы.Пользователь, 
				"Пользователь в строке определился правильно").Равно("Администратор");
	Ожидаем.Что(ПерваяСтрокаТаблицы.Метаданные, 
				"Объект метаданных в строке определился правильно").Равно("Конфигурация.СуперФорма");
	Ожидаем.Что(ПерваяСтрокаТаблицы.ДатаЗахвата, 
				"Дата захвата в строке определилась правильно").Равно('20231206161819');			

КонецПроцедуры


Процедура ТестДолжен_ПроверитьПолучениеТаблицыЗахватовВХранилищеСВыгрузкойИсходногоКода() Экспорт

	ЧтениеХранилища = Новый ЧтениеХранилища(ПутьКХранилищу2, ПутьКВыгрузкеКонфигурации);
	ЧтениеХранилища.ПрочитатьХранилище();	

	ТаблицаЗахватов = ЧтениеХранилища.ТаблицаЗахватов();
	
	Ожидаем.Что(ТаблицаЗахватов.Количество(), 
				"Количество захваченных объектов в хранилище 1").Равно(3);

	ПерваяСтрокаТаблицы = ТаблицаЗахватов[0];
	Ожидаем.Что(ПерваяСтрокаТаблицы.Пользователь, 
				"Пользователь в строке определился правильно").Равно("Администратор");
	Ожидаем.Что(ПерваяСтрокаТаблицы.Метаданные, 
				"Объект метаданных в строке определился правильно").Равно("CommonForm.СуперФорма");
	Ожидаем.Что(ПерваяСтрокаТаблицы.ДатаЗахвата, 
				"Дата захвата в строке определилась правильно").Равно('20231206161819');

КонецПроцедуры

Процедура ТестДолжен_ПроверитьПолучениеИнформацииОЗахватеКорня() Экспорт

	ЧтениеХранилища = Новый ЧтениеХранилища(ПутьКХранилищу1);
	ЧтениеХранилища.ПрочитатьХранилище();	

	ДанныеОЗахватеКорня = ЧтениеХранилища.КореньЗахвачен();
	
	Ожидаем.Что(ДанныеОЗахватеКорня.Захвачен, 
				"Корень в хранилище 1 захвачен").Равно(Истина);
	Ожидаем.Что(ДанныеОЗахватеКорня.Пользователь, 
				"Корень в хранилище 1 захвачен Администратором").Равно("Администратор");
	Ожидаем.Что(ДанныеОЗахватеКорня.Длительность, 
				"Длительность захвата корня в хранилище").Больше(10000);

	ЧтениеХранилища = Новый ЧтениеХранилища(ПутьКХранилищу2, ПутьКВыгрузкеКонфигурации);
	ЧтениеХранилища.ПрочитатьХранилище();	
			
	ДанныеОЗахватеКорня = ЧтениеХранилища.КореньЗахвачен();
	Ожидаем.Что(ДанныеОЗахватеКорня.Захвачен, 
				"Корень в хранилище 2 не захвачен").Равно(Ложь);

КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
КонецПроцедуры

КаталогСДанными = ОбъединитьПути(ТекущийСценарий().Каталог, "fixtures");
ПутьКХранилищу1 = ОбъединитьПути(КаталогСДанными, "storage1");
ПутьКХранилищу2 = ОбъединитьПути(КаталогСДанными, "storage2");
ПутьКВыгрузкеКонфигурации = ОбъединитьПути(КаталогСДанными, "src");