
&НаСервере
Процедура СеместрПриИзмененииНаСервере()
	Объект.ТЧ.Очистить();
	
	ЗапросСтуденты = Новый запрос; 
	ЗапросСтуденты.Текст = "ВЫБРАТЬ
	                       |	СписокСтудентов.Ссылка КАК Ссылка,
	                       |	СписокСтудентов.Группа КАК Группа
	                       |ИЗ
	                       |	Справочник.СписокСтудентов КАК СписокСтудентов
	                       |ГДЕ
	                       |	СписокСтудентов.СтатусЗачисления = &СтатусЗачисления"; 
	ЗапросСтуденты.УстановитьПараметр("СтатусЗачисления",Истина); 
    рез = ЗапросСтуденты.Выполнить().Выгрузить(); 
	Для каждого стр из рез Цикл 
	
	Запрос = Новый запрос; 
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Ссылка.Студент КАК Студент,
	               |	ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Ссылка.Группа КАК Группа,
	               |	ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Оценка КАК Оценка,
	               |	ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Долг КАК Долг
	               |ИЗ
	               |	Документ.ЗачетнаяКнижкаСтудента.СписокАттестационныхДисцилин КАК ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин
	               |ГДЕ
	               |	ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Семестр = &Семестр
	               |	И ЗачетнаяКнижкаСтудентаСписокАттестационныхДисцилин.Ссылка.Студент = &Студент";
	
	 Запрос.УстановитьПараметр("семестр",Объект.Семестр); 
	 Запрос.УстановитьПараметр("Студент",Стр.Ссылка); 
	 Р = Запрос.Выполнить().Выгрузить(); 
	 Для каждого строка из Р Цикл 
		 Если ПустаяСтрока(Строка.Оценка) ИЛИ Строка.Оценка = Перечисления.ВидыОценокЗачет.НеЗачтено ИЛИ Строка.Оценка = 2 
			 Тогда 
			 О = объект.ТЧ.Добавить(); 
			 О.Студент = Стр.Ссылка;
			 О.Группа = Стр.Группа; 
			 О.КоличествоНеЛиквидированныхАкадемЗадол = 1; 
			 
			 
		 КонецЕсли;
		 
			 
		 
	 КонецЦикла; 
	 
 КонецЦикла;  
 
 А = Объект.ТЧ.Выгрузить(); 
 А.Свернуть("Студент,Группа","КоличествоНеЛиквидированныхАкадемЗадол"); 
 Объект.ТЧ.Загрузить(А); 
 

	
КонецПроцедуры

&НаКлиенте
Процедура СеместрПриИзменении(Элемент)
	СеместрПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОтчислитьСтудентовНаСервере()
	
	Для каждого стр из Объект.ТЧ Цикл 
		Если Стр.Отчислить = Истина Тогда
			Спр= Справочники.СписокСтудентов.НайтиПоНаименованию(Стр.Студент).ПолучитьОбъект(); 
			Спр.СтатусЗачисления = Ложь; 
			Спр.Записать();
			Док = Документы.ФормированиеУчебныхГрупп.НайтиПоРеквизиту("НомерГруппы",Стр.Группа).ПолучитьОбъект(); 
			Парам = Новый Структура; 
			парам.Вставить("Студент",Стр.Студент); 
			НС = Док.СписокСтудентов.НайтиСтроки(Парам); 
			Для каждого Нстр из НС Цикл 
				
				НСтр.Отчислен = Истина;
				
			КонецЦикла; 
			Док.Записать(РежимЗаписиДокумента.Запись); 
			Док.Записать(РежимЗаписиДокумента.Проведение);
			
		КонецЕсли; 
		
		
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчислитьСтудентов(Команда)
	ОтчислитьСтудентовНаСервере();
КонецПроцедуры




