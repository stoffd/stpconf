#! /bin/sh

help () {
	
	echo	"this is very small frameWork by stoffD";
	echo	"USAGE stocc [OPTION1, OPTION2, .. OPTIONn]";
	echo	"Options:";
	echo	" -h, --help:		command list";
	echo	" -c [COMPILER]		choosing needfull compiler (gcc, g++, etc.)"
	echo	" -m creating new project"
	echo	" -d				project is a dynamic lib"
	echo	" -s				project is a static lib"
	echo	" -i [ LIBFILES ]   including libs in this project"
	echo	" -a [ NEW_SRC ]	adding new src with header"
	echo	" -n [ FILENAME ]	choose filename"
	return;}





addModule () {
	cat "$MY_PATH/$PROJECT_NAME/Makefile" | grep 'CC=g++'
	[ $? -eq 0 ] && PREFIX="cpp";
	
	echo '#include "./include/'"$1"'.h"' > "$MY_PATH/$PROJECT_NAME/$1.$PREFIX" ; 
	echo "#ifndef $1_$PREFIX" >  "$MY_PATH/$PROJECT_NAME/include/$1.h";

	echo "#define $1_$PREFIX" >>  "$MY_PATH/$PROJECT_NAME/include/$1.h";
	echo >>  "$MY_PATH/$PROJECT_NAME/include/$1.h";
	echo >>  "$MY_PATH/$PROJECT_NAME/include/$1.h";
	echo >>  "$MY_PATH/$PROJECT_NAME/include/$1.h";

	echo "#endif//$1_$PREFIX" >>  "$MY_PATH/$PROJECT_NAME/include/$1.h";
	TMP=`cat "$MY_PATH/$PROJECT_NAME/Makefile" | sed "s/#main_section/$1.o #main_section/g"`
	echo "$TMP" >  "$MY_PATH/$PROJECT_NAME/Makefile"; 

	TMP=`cat "$MY_PATH/$PROJECT_NAME/Makefile" | sed "s/#auto_trgt/$1.o: $1.$PREFIX/g"`
	echo "$TMP" >  "$MY_PATH/$PROJECT_NAME/Makefile"; 
	
	TMP=`cat "$MY_PATH/$PROJECT_NAME/Makefile" | sed 's/#auto_instr/	$(CC) -c $^ /g'`
	echo "$TMP" >  "$MY_PATH/$PROJECT_NAME/Makefile"; 



	
	TMP=`cat "$MY_PATH/$PROJECT_NAME/Makefile" | sed '/clean:/i\
#auto_trgt'` 
	echo "$TMP" >  "$MY_PATH/$PROJECT_NAME/Makefile"; 

	TMP=`cat "$MY_PATH/$PROJECT_NAME/Makefile" | sed '/clean:/i\
	#auto_instr'` 
	echo "$TMP" >  "$MY_PATH/$PROJECT_NAME/Makefile"; 
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";

	exit;

}




new_project () {

	[ $COMPILER = "g++" ] && PREFIX="cpp";

	mkdir "$MY_PATH/$PROJECT_NAME" ; 
	mkdir "$MY_PATH/$PROJECT_NAME/include";  
	[ $? -eq 0 ] || { echo "error. Maybe project is exist?"; exit; }

	echo "CC=$COMPILER"  > "$MY_PATH/$PROJECT_NAME/""Makefile";	
	echo "PROGRAM_NAME=$PROJECT_NAME" >> "$MY_PATH/$PROJECT_NAME/""Makefile";		
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo '$(PROGRAM_NAME): '"$FILENAME"'.o #main_section' >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo '	$(CC) -o $@ $^' >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo "$FILENAME"'.o: '"$FILENAME.$PREFIX" >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo '	$(CC) -c $^' >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo "#auto_trgt" >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo "#auto_instr" >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo "clean:" >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo '	rm -f *.o' >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	echo '	rm -f $(PROGRAM_NAME)' >> "$MY_PATH/$PROJECT_NAME/""Makefile";
	touch ""$MY_PATH/$PROJECT_NAME/""main".$PREFIX";
	exit ;
}	

# ------------ VARIABLES --------------------------
	PROJECT_NAME="new_project"
	MY_PATH="$PWD";
	COMPILER="gcc";
	EDITOR="gvim";
	FILENAME="main";
	PREFIX="c";
	MAIN_PREFIX=" "; # prefix of binary file
	LINK_FLAG=" ";
# ------------ END VARIABLES -----------------------
# ------------ в первом цикле используются опции устанавливающие значения переменных
	for I in $@; do

	
		[ "$PREV_PARAM" = "-n" ] && PROJECT_NAME="$I"; 	

		[ "$PREV_PARAM" = "-c" ] && COMPILER="$I"; 	


		[ "$I" = "-h" ] && help;
		
		[ "$I" = "--help" ] && help;
		PREV_PARAM="$I";

	done;

#-- второй цикл используется для проверки опций линковки в библиотеки
	for I in $@; do

		[ "$I" = "-s" ] && { MAIN_PREFIX=".a"; LINK_FLAG="rv"; FILENAME="lib$ROJECT_NAME$MAIN_PREFIX"; } ; 	

		[ "$I" = "-d" ] && { MAIN_PREFIX=".so"; LINK_FLAG="-shared"; FILENAME="lib$ROJECT_NAME$MAIN_PREFIX"; } ; 	

	 done;
# ---специально для статических архивов свой архиватор
	if  [ "$MAIN_PREFIX" = ".a" ]; then
		LIB_COMPILER="ar";
	else
		LIB_COMPILER="$COMPILER";
	fi;

#-- второй цикл выполняет непосредственно какое либо действие (создание проекта, добавления модуля и тд)
	
	PREV_PARAM=" ";	
	for I in $@; do

	
		[ "$I" = "-m" ] && new_project; 
		[ "$PREV_PARAM" = "-a" ] && addModule $I;
		
		PREV_PARAM="$I";
	done;
