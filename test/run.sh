#!/usr/bin/env bash

cd $(dirname $0)
cd ../complete

mvn clean package
ret=$?
[[ "$ret" -ne 0 ]] && exit $ret
rm -rf target

./gradlew build
ret=$?
[[ "$ret" -ne 0 ]] && exit $ret
rm -rf build

cd ../initial

mvn clean compile
ret=$?
[[ "$ret" -ne 0 ]] && exit $ret
rm -rf target

./gradlew compileJava
ret=$?
[[ "$ret" -ne 0 ]] && exit $ret
rm -rf build

exit 0
