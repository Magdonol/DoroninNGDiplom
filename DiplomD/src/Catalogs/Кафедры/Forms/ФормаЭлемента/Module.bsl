
&НаСервере
Процедура ПреподавательскийСоставПреподавательПриИзмененииНаСервере(Препод,Статус)
	Спр = Справочники.ПреподавательскийСостав.НайтиПоНаименованию(Препод); 
	Статус = Спр.Должность;
КонецПроцедуры

&НаКлиенте
Процедура ПреподавательскийСоставПреподавательПриИзменении(Элемент)
	
Стр = Элементы.ПреподавательскийСостав.ТекущиеДанные; 
	
Препод = Стр.Преподаватель; 
	
Статус = "";
	
ПреподавательскийСоставПреподавательПриИзмененииНаСервере(Препод,Статус);

 Стр.СтатусПреподавателя = Статус;
КонецПроцедуры
