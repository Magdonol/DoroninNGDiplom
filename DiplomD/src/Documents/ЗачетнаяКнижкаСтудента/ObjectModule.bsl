Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр УспеваемостьСтудентов 
	Движения.УспеваемостьСтудентов.Записывать = Истина;
	Для Каждого ТекСтрокаСписокАттестационныхДисцилин Из СписокАттестационныхДисцилин Цикл
		Движение = Движения.УспеваемостьСтудентов.Добавить();
		Движение.Период = Дата;
		Движение.Студент = Студент;
		Движение.Группа = Группа;
		Движение.Семестр = ТекСтрокаСписокАттестационныхДисцилин.Семестр;
	Если ТекСтрокаСписокАттестационныхДисцилин.Оценка = 4 ИЛИ ТекСтрокаСписокАттестационныхДисцилин.Оценка = 5 Тогда 
			Движение.КоличествоОценокХорОтл = 1; 
		КонецЕсли; 
		Если ТекСтрокаСписокАттестационныхДисцилин.Оценка = Перечисления.ВидыОценокЗачет.Зачтено Тогда 
			Движение.КоличествоОценокЗачтено = 1; 
		КонецЕсли; 
		Если ТекСтрокаСписокАттестационныхДисцилин.Оценка = 3 Тогда 
			Движение.КоличествоОценокУдв = 1; 
		КонецЕсли; 
		Если ПустаяСтрока(ТекСтрокаСписокАттестационныхДисцилин) ИЛИ ТекСтрокаСписокАттестационныхДисцилин.Долг = Истина Тогда 
			Движение.КоличествоАкадемическихЗадолженностей = 1; 
		КонецЕсли; 	
	КонецЦикла;

	// регистр Сессия 
	Движения.Сессия.Записывать = Истина;
	Для Каждого ТекСтрокаСписокАттестационныхДисцилин Из СписокАттестационныхДисцилин Цикл
		Движение = Движения.Сессия.Добавить();
		Движение.Период = Дата;
		Движение.Семестр = ТекСтрокаСписокАттестационныхДисцилин.Семестр;
		Движение.Группа = Группа;
		Если ТекСтрокаСписокАттестационныхДисцилин.Оценка = 4 ИЛИ ТекСтрокаСписокАттестационныхДисцилин.Оценка = 5
			ИЛИ ТекСтрокаСписокАттестационныхДисцилин.Оценка = Перечисления.ВидыОценокЗачет.Зачтено ИЛИ ТекСтрокаСписокАттестационныхДисцилин.Оценка = 3  
			
			Тогда 
			Движение.КолчиествоВыставленныхОценок = 1;
		Иначе 
			Движение.КоличествоАкадемическихЗадолженностей = 1; 
		КонецЕсли;
		Если  ТекСтрокаСписокАттестационныхДисцилин.перезачтено = Истина Тогда 
			Движение.КоличествоПроведенныхПереаттестаций = 1; 
		КонецЕсли; 
		
	КонецЦикла; 
	
		
	
КонецПроцедуры
