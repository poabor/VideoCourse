﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЕстьДатаРожденияЧеловека(Парам01)","ЕстьДатаРожденияЧеловека","Допустим есть дата рождения человека 01.01.2016");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ДатаПроверки(Парам01)","ДатаПроверки","И дата проверки 01.03.2016");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РезультатБудетРавен(Парам01)","РезультатБудетРавен","Тогда Результат будет равен 2");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим есть дата рождения человека 01.01.2016
//@ЕстьДатаРожденияЧеловека(Парам01)
Процедура ЕстьДатаРожденияЧеловека(ДатаОтсчета) Экспорт
	Контекст.Вставить("ДатаОтсчета", ДатаОтсчета);
КонецПроцедуры

&НаКлиенте
//И дата проверки 01.03.2016
//@ДатаПроверки(Парам01)
Процедура ДатаПроверки(ДатаПроверки) Экспорт
	Контекст.Вставить("ДатаПроверки", ДатаПроверки);
КонецПроцедуры

&НаКлиенте
//Тогда Результат будет равен 2
//@РезультатБудетРавен(Парам01)
Процедура РезультатБудетРавен(ОжидаемыйРезультат) Экспорт
	Результат = ОбщийМодуль1.РазобратьРазностьДат(Контекст.ДатаПроверки, Контекст.ДатаОтсчета);
	Если Не ОжидаемыйРезультат = Результат Тогда
		ВызватьИсключение "Ожидали: " + ОжидаемыйРезультат+ ", а получили: " + Результат;
	КонецЕсли; 
КонецПроцедуры

//окончание текста модуля