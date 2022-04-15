echo "Лабораторная работа №1"
echo "Программа выводит данные о файле"
echo "Автор: Пашкевич Станислав (Теневой Бражник)"

while true; do

echo " "
	echo -n "Укажите каталог, в котором находится файл: "
	read place
	if !(ls $place) ; then
		echo  "Такого каталога нет! Повторите попытку: "
		continue
		fi
	while true; do
	read -p "Введите имя файла: " name_file	
	if [ -e "$name_file" ]
	then
	echo "Файл уже существует!"
	
	echo "Имя файла: " $(stat --format %n $name_file)
	echo "Тип файла: " $(stat --format %F $name_file)
	echo "Размер файла: " $(stat --format %s $name_file)
	echo "Владелец файла: " $(stat --format %U $name_file)
	echo "Права доступа к файлу: " $(stat --format %A $name_file)
	echo "Время создания файла: " $(stat --format %w $name_file)
		
	break
	else 
	echo "Ошибка! Такого файла нет."
	fi
	done
	
	echo "Хотите продолжить? (y/n)"
	read yn
        if [ $yn = "y" ]
        then continue
        else break
        fi

done
