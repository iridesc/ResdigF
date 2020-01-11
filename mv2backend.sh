#/bin/bash
rm ../ResdigB/resdig/templates/index.html
cp ./dist/index.html ../ResdigB/resdig/templates

rm -r ../ResdigB/resdig/static/*

cp -r ./dist/static/* ../ResdigB/resdig/static/
