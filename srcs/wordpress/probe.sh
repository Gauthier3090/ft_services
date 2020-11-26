#!/bin/bash

pgrep php-fpm 2> /dev/null > test
[ -s test ]
if [ $? != 0 ]; then
	return
else
	echo "php-fpm is ok"
fi
