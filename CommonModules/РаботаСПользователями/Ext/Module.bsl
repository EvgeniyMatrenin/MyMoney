﻿
Функция НайтиСоздатьПользователя() Экспорт

	ПользовательИБ = Неопределено;
	ПользователиИБ = ПользователиИнформационнойБазы.ПолучитьПользователей();
	
	Если ПользователиИБ.Количество() = 0 Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
		ПользовательИБ.Имя       = "Администратор";
		ПользовательИБ.ПолноеИмя = ПользовательИБ.Имя;
		ПользовательИБ.Роли.Очистить();
		ПользовательИБ.Роли.Добавить(Метаданные.Роли.ПолныеПрава);
		ПользовательИБ.Записать();
		
		Пользователь = Справочники.Пользователи.НайтиПоРеквизиту(
		"ИДПользователяИБ", ПользовательИБ.УникальныйИдентификатор);
	Иначе
		Пользователь = Справочники.Пользователи.НайтиПоНаименованию(ИмяПользователя(), Истина);
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Пользователь) Тогда
		Пользователь = Справочники.Пользователи.НайтиПоНаименованию(ПользовательИБ.ПолноеИмя);
		
		Если ЗначениеЗаполнено(Пользователь)
			И ЗначениеЗаполнено(Пользователь.ИДПользователяИБ)
			И Пользователь.ИДПользователяИБ <> ПользовательИБ.УникальныйИдентификатор Тогда
			
			Пользователь = Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Пользователь) Тогда
		Пользователь = Справочники.Пользователи.СоздатьЭлемент();
		ПользовательСоздан = Истина;
	Иначе
		Пользователь = Пользователь.ПолучитьОбъект();
		ПользовательСоздан = Ложь;
	КонецЕсли;
	
	Если ПользовательИБ <> Неопределено Тогда
	
		Пользователь.Наименование = ПользовательИБ.ПолноеИмя;
		Пользователь.ИДПользователяИБ = ПользовательИБ.УникальныйИдентификатор;
		
		Пользователь.Записать();
	
	КонецЕсли; 
	
	Возврат Пользователь.Ссылка;

КонецФункции // НайтиСоздатьПользователя()
