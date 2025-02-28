#!/bin/bash

set -e
C_=$(dirname "$(realpath "$0")")

#<<'#'
CC_="gcc   -c -xc -std=c2x -O3 -ftrack-macro-expansion=0 -Werror -iprefix
'$C_'/.include -iwithprefix/ellipsis  -iwithprefix/dialect -iwithprefix/library
-iprefix '$C_'/include -iwithprefix/. -iwithprefix/class -iwithprefix/interface
-Wall -Wextra -Wpedantic -Wcast-align -Wcast-qual -Wswitch-enum -Wwrite-strings
-Wduplicated-branches    -Winit-self  -Wshift-overflow=2
-Wduplicated-cond  -Wnull-dereference -Wstrict-overflow=2
-Wno-override-init -Wno-missing-field-initializers
-Wno-parentheses   -Wno-tautological-compare -Wno-type-limits"
#

<<'#'
CC_="clang -c -xc -std=c2x -O3 -fmacro-backtrace-limit=1 -Werror -iprefix
'$C_'/.include -iwithprefix/ellipsis  -iwithprefix/dialect -iwithprefix/library
-iprefix '$C_'/include -iwithprefix/. -iwithprefix/class -iwithprefix/interface
-Wall -Wextra -Wpedantic -Wcast-align -Wcast-qual -Wswitch-enum -Wwrite-strings
-Wassign-enum -Wshift-sign-overflow   -Wunreachable-code-aggressive
-Wno-override-init -Wno-missing-field-initializers -Wno-pointer-arith"
#

cd  "$C_"/compile
eval $CC_ lib.c_
strip --strip-unneeded lib.o
cd ..
mkdir -p object
mv compile/lib.o object
cd object

mkdir -p class
cd class
eval $CC_ "'$C_'"/compile/class/*.c_
strip --strip-unneeded *.o
for d in $(cd ../../compile/class     &&  ls -d */)
do
	mkdir -p $d
	cd $d
	eval $CC_ "'$C_'/compile/class/$d"*.c_
	strip --strip-unneeded *.o
	cd ..
done

cd ..

mkdir -p interface
cd interface
eval $CC_ "'$C_'"/compile/interface/*.c_
strip --strip-unneeded *.o
for d in $(cd ../../compile/interface &&  ls -d */)
do
	mkdir -p $d
	cd $d
	eval $CC_ "'$C_'/compile/interface/$d"*.c_
	strip --strip-unneeded *.o
	cd ..
done
