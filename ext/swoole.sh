#!bin/bash
if  [ ! -n "$prj_path" ] ;then
    prj_path=$(cd ../$(dirname $0); pwd -P)
fi
source $prj_path/config.sh
package=$prj_path/package

if [ ! -d "$package/swoole" ]; then
    mkdir $package/swoole
fi
rm -rf $package/swoole/*
wget -O $package/swoole.tar.gz $PHP_EXT_SWOOLE_DOWNLOAD_URL 

tar -zxvf $package/swoole.tar.gz -C $package/swoole/ --strip-components 1
cd $package/swoole 
$PHP_PATH/bin/phpize
./configure --with-php-config=$PHP_PATH/bin/php-config
make install
if [ $? eq 0 ]; then
    echo -e swoole install success. `date` >> install.log
else
    echo -e swoole install fail. `date` >> install.log
fi