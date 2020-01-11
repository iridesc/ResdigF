#/bin/bash
rm ../ocolab/resdig/templates/index.html
cp ./dist/index.html ../ocolab/resdig/templates

rm -r ../ocolab/resdig/static/*

cp -r ./dist/static/* ../ocolab/resdig/static/
