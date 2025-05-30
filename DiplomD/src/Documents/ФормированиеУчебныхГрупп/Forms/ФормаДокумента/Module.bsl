
&НаСервере
Процедура ПланОбученияПреподавательПриИзмененииНаСервере(Препод,Ведет,Дисц)
	Запрос = Новый Запрос; 
	Запрос.Текст = "ВЫБРАТЬ
	|	РабочаяПрограммаДисцилиныПреподавательскийСостав.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.РабочаяПрограммаДисцилины.ПреподавательскийСостав КАК РабочаяПрограммаДисцилиныПреподавательскийСостав
	|ГДЕ
	|	РабочаяПрограммаДисцилиныПреподавательскийСостав.Ссылка = &Ссылка
	|	И РабочаяПрограммаДисцилиныПреподавательскийСостав.Преподаватель = &Преподаватель";
	Запрос.УстановитьПараметр("Ссылка",Дисц); 
	Запрос.УстановитьПараметр("Преподаватель",Препод);
	рез = Запрос.Выполнить().Выбрать(); 
	рез.Следующий(); 
	Если ПустаяСтрока(рез.ссылка) тогда 
		Ведет = 0; 
	Иначе 
		Ведет = 1; 
	КонецЕсли; 
	 

КонецПроцедуры

&НаКлиенте
Процедура ПланОбученияПреподавательПриИзменении(Элемент)
	Стр = Элементы.ПланОбучения.ТекущиеДанные; 
	Препод = Стр.Преподаватель; 
	Дисц = Стр.Дисциплина; 
	Ведет = 0; 
	ПланОбученияПреподавательПриИзмененииНаСервере(Препод,Ведет,Дисц); 
	Если Ведет = 0 Тогда 
		Сообщить("Выбранный преподаватель не ведет дисциплину" + " " + Дисц); 
		Стр.Преподаватель = "";
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура НомерГруппыПриИзмененииНаСервере()
	Спр = Справочники.Группы.НайтиПоНаименованию(Объект.НомерГруппы); 
	Объект.ФормаОбучения =  Спр.ФормаОбучения; 
	Объект.ПрофильНаправления = Спр.ПрофильНаправления; 
	Объект.Куратор = Спр.Куратор;
	Объект.Курс = Спр.Курс;
	
КонецПроцедуры

&НаКлиенте
Процедура НомерГруппыПриИзменении(Элемент)
	НомерГруппыПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоставитьСписокГруппыНаСервере()
		Объект.СписокСтудентов.Очистить();
	Запрос = Новый Запрос; 
	Запрос.Текст = "ВЫБРАТЬ
	|	СписокСтудентов.Ссылка КАК Ссылка,
	|	СписокСтудентов.НомерЗачетнойКнижки КАК НомерЗачетнойКнижки
	|ИЗ
	|	Справочник.СписокСтудентов КАК СписокСтудентов
	|ГДЕ
	|	СписокСтудентов.Группа = &Группа
	|	И СписокСтудентов.ФормаОбучения = &ФормаОбучения
	|	И СписокСтудентов.ПрофильНаправления = &ПрофильНаправления";
	Запрос.УстановитьПараметр("Группа",Объект.НомерГруппы); 
	Запрос.УстановитьПараметр("ФормаОбучения",Объект.ФормаОбучения); 
	Запрос.УстановитьПараметр("ПрофильНаправления",Объект.ПрофильНаправления); 
	Рез = Запрос.Выполнить().Выгрузить(); 
	Для каждого стр из рез Цикл
		О = Объект.СписокСтудентов.Добавить(); 
		О.Студент = Стр.Ссылка; 
		О.НомерЗачетнойКнижки = Стр.НомерЗачетнойКнижки; 
		
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура СоставитьСписокГруппы(Команда)
	СоставитьСписокГруппыНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоставитьПланОбученияНаСервере()
	Объект.ПланОбучения.Очистить();
	Запрос = Новый Запрос; 
	Запрос.Текст = "ВЫБРАТЬ
	|	РабочаяПрограммаДисцилиныАттестация.Семестр КАК Семестр,
	|	РабочаяПрограммаДисцилиныАттестация.Ссылка КАК Ссылка,
	|	РабочаяПрограммаДисцилиныАттестация.ВидАттестации КАК ВидАттестации,
	|	РабочаяПрограммаДисцилиныАттестация.КоличествоЧасов КАК КоличествоЧасов
	|ИЗ
	|	Справочник.РабочаяПрограммаДисцилины.Аттестация КАК РабочаяПрограммаДисцилиныАттестация
	|ГДЕ
	|	РабочаяПрограммаДисцилиныАттестация.ФормаОбучения = &ФормаОбучения
	|	И РабочаяПрограммаДисцилиныАттестация.ПрофильНаправления = &ПрофильНаправления";
	Запрос.УстановитьПараметр("ФормаОбучения",Объект.ФормаОбучения); 
	Запрос.УстановитьПараметр("ПрофильНаправления",Объект.ПрофильНаправления); 
	рез = Запрос.Выполнить().Выгрузить(); 
	Для каждого стр из рез Цикл
		О = Объект.ПланОбучения.Добавить(); 
		О.Дисциплина = Стр.Ссылка;
		О.Семестр = Стр.Семестр;
		О.ВидАттестации = Стр.ВидАттестации;
		О.КоличествоЧасов = Стр.КоличествоЧасов; 
		
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура СоставитьПланОбучения(Команда)
	СоставитьПланОбученияНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьЗачетноЭкзаменационныеВедомостиНаСервере()
	ПоискВедомостей = Новый запрос; 
	ПоискВедомостей.Текст = "ВЫБРАТЬ
	|	ЗачетноЭкзаментационнаяВедомость.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.ЗачетноЭкзаментационнаяВедомость КАК ЗачетноЭкзаментационнаяВедомость
	|ГДЕ
	|	ЗачетноЭкзаментационнаяВедомость.Основание = &Основание
	|	И ЗачетноЭкзаментационнаяВедомость.Семестр = &Семестр
	|	И ЗачетноЭкзаментационнаяВедомость.Группа = &Группа";
	ПоискВедомостей.УстановитьПараметр("Основание",Объект.Ссылка); 
	ПоискВедомостей.УстановитьПараметр("Семестр",Объект.Семестр);
	ПоискВедомостей.УстановитьПараметр("Группа",Объект.НомерГруппы);
	Ррр = ПоискВедомостей.Выполнить().Выгрузить(); 
	Если Ррр.Количество() = 0 Тогда 
		Парам = Новый Структура; 
		Парам.Вставить("Семестр",Объект.Семестр); 
		НС = Объект.ПланОбучения.НайтиСтроки(Парам); 
		Для каждого стр из НС Цикл  
			Док = Документы.ЗачетноЭкзаментационнаяВедомость.СоздатьДокумент(); 
			Док.Группа = Объект.НомерГруппы;
			Док.Дата = ТекущаяДата(); 
			Док.Семестр = Объект.Семестр; 
			Док.Дисциплина = стр.Дисциплина; 
			Док.Преподаватель = Стр.Преподаватель; 
			Док.Основание = Объект.Ссылка; 
			Дисц =  стр.Дисциплина;  
			Док.КоличествоЧасов = Стр.КОличествоЧасов; 
			Док.ФормаАттестации = Стр.ВидАттестации; 
			
			
			Для каждого строка из Объект.СписокСтудентов Цикл 
				Если Строка.Отчислен = Ложь Тогда 
					О = Док.СписокСтудентов.Добавить(); 
					О.Студент = Строка.Студент; 
					О.НомерЗачетнойКнижки = Строка.НомерЗачетнойКнижки; 
					ЗапросПромАттест = Новый Запрос; 
					ЗапросПромАттест.Текст = "ВЫБРАТЬ
					|	ПромежуточнаяАттестацияТЧ.БаллПромежуточнойАттестации КАК БаллПромежуточнойАттестации,
					|	ПромежуточнаяАттестацияТЧ.Ссылка.ОбъемДисциплины КАК ОбъемДисциплины
					|ИЗ
					|	Документ.ПромежуточнаяАттестация.ТЧ КАК ПромежуточнаяАттестацияТЧ
					|ГДЕ
					|	ПромежуточнаяАттестацияТЧ.Студент = &Студент
					|	И ПромежуточнаяАттестацияТЧ.Ссылка.Дисциплина = &Дисциплина
					|	И ПромежуточнаяАттестацияТЧ.Ссылка.Семестр = &Семестр";  
					ЗапросПромАттест.УстановитьПараметр("Дисциплина",Дисц); 
					ЗапросПромАттест.УстановитьПараметр("Семестр",Объект.Семестр); 
					ЗапросПромАттест.УстановитьПараметр("Студент", Строка.Студент);
					Рез = ЗапросПромАттест.Выполнить().Выгрузить();  
					Выборка =   ЗапросПромАттест.Выполнить().Выбрать(); 
					Выборка.Следующий(); 
					А = Док.ПромежуточнаяАттестацияПоДисциплине.Добавить(); 
					А.Студент = Строка.Студент; 
					А.ОбщийБаллУчебногоРейтинга = Рез.Итог("БаллПромежуточнойАттестации");
					А.ОбъемДисциплины = Выборка.ОбъемДисциплины; 
					ЗапросПоисктекКонтрол = Новый Запрос; 
					ЗапросПоисктекКонтрол.Текст = "ВЫБРАТЬ
					|	ТекущийКонтрольСписокСтудентов.Оценка КАК Оценка
					|ИЗ
					|	Документ.ТекущийКонтроль.СписокСтудентов КАК ТекущийКонтрольСписокСтудентов
					|ГДЕ
					|	ТекущийКонтрольСписокСтудентов.Студент = &Студент
					|	И ТекущийКонтрольСписокСтудентов.Ссылка.Семестр = &Семестр
					|	И ТекущийКонтрольСписокСтудентов.Ссылка.Дисциплина = &Дисциплина";
					
					ЗапросПоисктекКонтрол.УстановитьПараметр("Студент",Строка.Студент); 
					ЗапросПоисктекКонтрол.УстановитьПараметр("Семестр",Объект.Семестр); 
					ЗапросПоисктекКонтрол.УстановитьПараметр("Дисциплина",Дисц); 
					Р = ЗапросПоисктекКонтрол.Выполнить().Выгрузить(); 
					СреБалл = Р.Итог("Оценка")/Р.Количество(); 
					А.СреднийБалл = СреБалл; 
					
					Спр = Справочники.ОбъемыПромежуточнойАттестации.НайтиПоНаименованию(Выборка.ОбъемДисциплины); 

					Оценка = "";
					ПереводВЧетырехБалСистему.Перевод(А.ОбщийБаллУчебногоРейтинга,Оценка,Спр.Ссылка); 
					Спр = Справочники.ОбъемыПромежуточнойАттестации.НайтиПоНаименованию(Выборка.ОбъемДисциплины); 
					
					 
						А.рекомендуемаяОценка = Оценка; 
					
				КонецЕсли; 
				
			КонецЦикла; 
			
			Попытка 
				Док.Записать(РежимЗаписиДокумента.Запись); 
				Док.Записать(РежимЗаписиДокумента.Проведение); 
				Сообщить("Создана зачетно-экзаменационная ведомость на" + " " + Объект.Семестр + " "  + "для группы" + " " + Объект.НомерГруппы); 
			Исключение 
				Сообщить("Ведомость не создана"); 
			КонецПопытки; 
			
		 
		
	КонецЦикла; 
	
Иначе 
	СОобщить("ранее были созданы зачетно-экзаменационные ведомости на" + " " + объект.Семестр + "для группы" + " "+ объект.НомерГруппы); 
КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗачетноЭкзаменационныеВедомости(Команда)
	СоздатьЗачетноЭкзаменационныеВедомостиНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьДокументыТекущегоКонтроляНаСервере()
	ЗапросДокументы = Новый Запрос; 
	ЗапросДокументы.Текст = "ВЫБРАТЬ
	|	ТекущийКонтроль.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.ТекущийКонтроль КАК ТекущийКонтроль
	|ГДЕ
	|	ТекущийКонтроль.Основание = &Основание
	|	И ТекущийКонтроль.Группа = &Группа
	|	И ТекущийКонтроль.Семестр = &Семестр";  
	ЗапросДокументы.УстановитьПараметр("Основание",Объект.Ссылка);
	ЗапросДокументы.УстановитьПараметр("Группа",Объект.НомерГруппы);
	ЗапросДокументы.УстановитьПараметр("Семестр",Объект.Семестр);
	Ра = ЗапросДокументы.Выполнить().Выгрузить();
	Если Ра.Количество() = 0 Тогда 
		Запрос = Новый Запрос; 
		Запрос.Текст = "ВЫБРАТЬ
		|	РабочаяПрограммаДисцилинытекущийКонтроль.Ссылка КАК Ссылка,
		|	РабочаяПрограммаДисцилинытекущийКонтроль.ВидКонтроля КАК ВидКонтроля
		|ИЗ
		|	Справочник.РабочаяПрограммаДисцилины.текущийКонтроль КАК РабочаяПрограммаДисцилинытекущийКонтроль
		|ГДЕ
		|	РабочаяПрограммаДисцилинытекущийКонтроль.Семестр = &Семестр
		|	И РабочаяПрограммаДисцилинытекущийКонтроль.ФормаОбучения = &ФормаОбучения
		|	И РабочаяПрограммаДисцилинытекущийКонтроль.ПрофильНаправления = &ПрофильНаправления";
		Запрос.УстановитьПараметр("Семестр",Объект.Семестр); 
		Запрос.УстановитьПараметр("ФормаОбучения",объект.ФормаОбучения); 
		Запрос.УстановитьПараметр("ПрофильНаправления",Объект.ПрофильНаправления); 
		рез = Запрос.Выполнить().Выгрузить(); 
		Для каждого стр из Рез Цикл
			Док = Документы.ТекущийКонтроль.СоздатьДокумент(); 
			Док.Дата = ТекущаяДата(); 
			Док.Дисциплина = Стр.Ссылка; 
			Док.Группа = Объект.НомерГруппы; 
			Парам = Новый Структура; 
			Парам.Вставить("Дисциплина",Стр.Ссылка); 
			Парам.Вставить("Семестр",Объект.Семестр); 
			НС = Объект.ПланОбучения.НайтиСтроки(Парам); 
			Для каждого строчка из НС Цикл 
				
				Док.Преподаватель = Строчка.Преподаватель; 
			КонецЦикла; 
			Док.Семестр = Объект.Семестр; 
			Док.ВидКонтроля = Стр.ВидКонтроля; 
			Док.Основание = Объект.Ссылка; 
			
			Для каждого Строка из Объект.СписокСтудентов Цикл 
				Если Строка.Отчислен = ложь Тогда 
					А = Док.СписокСтудентов.Добавить(); 
					А.Студент = Строка.Студент; 
					А.НомерСтуденческогоБилета = Строка.НомерЗачетнойКнижки; 
				КонецЕсли; 
				
				
			КонецЦикла; 
			Попытка
				
				Док.Записать(РежимЗаписиДокумента.Запись); 
				Док.Записать(РежимЗаписиДокумента.Проведение); 
				Сообщить("Создан документ текущего контроля"); 
			Исключение 
				Сообщить("Документ текущего контроля НЕ создан"); 
			КонецПопытки; 
			
			
		КонецЦикла; 
	Иначе 
		Сообщить("Ранее были созданы документы текущего контроля на" + " " + Объект.Семестр + " " + "для группы" + " " + объект.НомерГруппы); 
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДокументыТекущегоКонтроля(Команда)
	СоздатьДокументыТекущегоКонтроляНаСервере();
КонецПроцедуры
