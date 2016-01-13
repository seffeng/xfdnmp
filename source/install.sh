#!/bin/bash

##------------------------------------------------------------------------------
##获取shell颜色
function get_shl_color(){
    local color="0";
    case $1 in
        red) color="1";       ##红
        ;;
        green) color="2";     ##绿
        ;;
        yellow) color="3";    ##黄
        ;;
        blue) color="4";      ##蓝
        ;;
        purple) color="5";    ##紫
        ;;
        blues) color="6";     ##青
        ;;
        *) color="0";         ##默认
        ;;
    esac
    return $color;
}
##获取shell样式
function get_shl_style(){
    local style="3";
    case $1 in
        _) style="2"; ##下划线
        ;;
        b) style="4"; ##背景
        ;;
        *) style="3"; ##无
        ;;
    esac
    return $style;
}
## 输出不换行
function get_style(){
    local color="0",style="4",style_color="0";
    get_shl_color "$1";
    color=$?;
    get_shl_color "$2";
    style_color=$?;
    get_shl_style "$3";
    style=$?;
    echo -n -e "\033[${style}${style_color};3${color}""m";
}
## 输出不换行
function print(){
    if [ "" != "$2" ]; then
        get_style "$2" "$3" "$4";
    fi
    echo -n -e "$1""\033[0m";
}
## 输出换行
function println(){
    if [ "" != "$2" ]; then
        get_style "$2" "$3" "$4";
    fi
    echo -e "$1""\033[0m";
}
## 执行命令
function shl_exec(){
    eval "$1";
}
## 终止退出
function shl_exit(){
    exit;
}
##------------------------------------------------------------------------------
##解析参数
function to_argv(){
    OLD_IFS="$IFS";
    IFS=" ";
    arr=($argvs);
    IFS="$OLD_IFS";
    for tmp in ${arr[@]};
    do
        lastvar='';
        IFS="=";
        arr_tmp=($tmp);
        IFS="$OLD_IFS";
        for tmps in ${arr_tmp[@]};
        do
            if [ '' == "$lastvar" ]; then
                lastvar=`echo $tmps|awk '{print substr($0, 3)}'`;
            else
                shl_exec ${lastvar}="'${tmps}'";
            fi
        done
    done
}
##------------------------------------------------------------------------------
argvs=$*;
clear
help=0;
ins_apr=0;
ins_apr_util=0;
ins_bzip2=0;
ins_cmake=0;
ins_scons=0;
ins_libmcrypt=0;
ins_libmemcached=0;
ins_mcrypt=0;
ins_memcached=0;
ins_mhash=0;
ins_mysql=0;
ins_nginx=0;
ins_openssl=0;
ins_pcre=0;
ins_php=0;
ins_php_memcache=0;
ins_pureftpd=0;
ins_redis=0;
ins_sqlite=0;
ins_serf=0;
ins_subversion=0;
ins_zlib=0;
is_debug=1;    #是否调试模式[1-是,0-否]

##软件名称和源码路径,更新软件版本时修改此处-------------------------------------
apr_pack_folder="apr-1.5.2";
apr_pack_name="${apr_pack_folder}.tar.bz2";
apr_util_pack_folder="apr-util-1.5.4";
apr_util_pack_name="${apr_util_pack_folder}.tar.bz2";
bzip2_pack_folder="bzip2-1.0.6";
bzip2_pack_name="${bzip2_pack_folder}.tar.gz";
cmake_pack_folder="cmake-3.4.1";
cmake_pack_name="${cmake_pack_folder}.tar.gz";
scons_pack_folder="scons-local-2.4.1";
scons_pack_name="${scons_pack_folder}.tar.gz";
libmcrypt_pack_folder="libmcrypt-2.5.8";
libmcrypt_pack_name="${libmcrypt_pack_folder}.tar.gz";
libmemcached_pack_folder="libmemcached-1.0.18";
libmemcached_pack_name="${libmemcached_pack_folder}.tar.gz";
mcrypt_pack_folder="mcrypt-2.6.8";
mcrypt_pack_name="${mcrypt_pack_folder}.tar.gz";
memcache_pack_folder="memcached-1.4.25";
memcache_pack_name="${memcache_pack_folder}.tar.gz";
mhash_pack_folder="mhash-0.9.9.9";
mhash_pack_name="${mhash_pack_folder}.tar.gz";
mysql_pack_folder="mysql-5.5.47";
mysql_pack_name="${mysql_pack_folder}.tar.gz";
nginx_pack_folder="nginx-1.8.0";
nginx_pack_name="${nginx_pack_folder}.tar.gz";
openssl_pack_folder="openssl-1.0.2e";
openssl_pack_name="${openssl_pack_folder}.tar.gz";
pcre_pack_folder="pcre-8.38";
pcre_pack_name="${pcre_pack_folder}.tar.bz2";
php_pack_folder="php-7.0.2";
php_pack_name="${php_pack_folder}.tar.bz2";
php_memcache_pack_folder="memcache-3.0.8";
php_memcache_pack_name="${php_memcache_pack_folder}.tgz";
pureftpd_pack_folder="pure-ftpd-1.0.36";
pureftpd_pack_name="${pureftpd_pack_folder}.tar.bz2";
redis_pack_folder="redis-3.0.6";
redis_pack_name="${redis_pack_folder}.tar.gz";
sqlite_pack_folder="sqlite-autoconf-3090200";
sqlite_pack_name="${sqlite_pack_folder}.tar.gz";
serf_pack_folder="serf-1.3.8";
serf_pack_name="${serf_pack_folder}.tar.bz2";
subversion_pack_folder="subversion-1.8.15";
subversion_pack_name="${subversion_pack_folder}.tar.bz2";
zlib_pack_folder="zlib-1.2.8";
zlib_pack_name="${zlib_pack_folder}.tar.gz";


##------------------------------------------------------------------------------
println "********************************************************************************" yellow;
println "CONFIGURE DEBIAN SERVER";
println "********************************************************************************\n" yellow;
shl_cmd="apt-get -y install gcc g++ make automake autoconf bzip2";
url_software_base="/srv/websrv/source/";        ## 安装程序路径
url_install_base="/srv/websrv/program/";        ## 安装结果路径
url_config_base="/srv/websrv/config/";          ## 配置文件路径
url_data_base="/srv/websrv/data/";              ## 安装数据路径
url_sbin_base="/usr/bin/";                      ## 系统执行命令路径
url_path_base=$(dirname $url_install_base)/;    ## 安装程序根目录
to_argv;

if [ 1 = $ins_mysql ]; then
ins_cmake=1;
fi

if [ 1 = $ins_nginx ]; then
ins_pcre=1;
ins_zlib=1;
ins_openssl=1;
fi

if [ 1 = $ins_php ]; then
ins_bzip2=1;
ins_mhash=1;
ins_libmcrypt=1;
ins_mcrypt=1;
fi

if [ 1 = $ins_subversion ]; then
ins_apr=1;
ins_apr_util=1;
ins_scons=1;
ins_sqlite=1;
ins_serf=1;
fi

if [ 1 = $ins_serf ]; then
ins_apr=1;
ins_apr_util=1;
ins_scons=1;
ins_openssl=1;
fi

if [ 1 = $help ]; then
println "${url_software_base}install.sh --url_software_base=${url_software_base} --url_install_base=${url_install_base} --url_config_base=${url_config_base} --url_data_base=${url_data_base} --is_debug=1" blues;
exit;
fi
if [ 0 = $is_debug ]; then
println "    Installation Mode" blues;
else
println "    Debug Mode" blues;
fi
println "Source Path: [$url_software_base]" blues;
println "Program Path: [$url_install_base]" blues;
if [ 0 = $is_debug ]; then
shl_exec "$shl_cmd";
shl_exec "if [ ! -f /usr/bin/automake-1.15 ] ; then (ln -s /usr/bin/automake /usr/bin/automake-1.15) fi";
shl_exec "if [ ! -f /usr/bin/aclocal-1.15 ] ; then (ln -s /usr/bin/aclocal /usr/bin/aclocal-1.15) fi";
shl_exec "mkdir -p $url_install_base";
shl_exec "mkdir -p $url_config_base";
shl_exec "mkdir -p $url_data_base";
shl_exec "mkdir -p $url_path_base";
shl_exec "mkdir -p ${url_path_base}tmp ${url_path_base}logs";
shl_exec "chmod 777 ${url_path_base}tmp ${url_path_base}logs";
else
println "$shl_cmd" purple;
println "if [ ! -f /usr/bin/automake-1.15 ] ; then (ln -s /usr/bin/automake /usr/bin/automake-1.15) fi" purple;
println "if [ ! -f /usr/bin/aclocal-1.15 ] ; then (ln -s /usr/bin/aclocal /usr/bin/aclocal-1.15) fi" purple;
println "mkdir -p $url_install_base" purple;
println "mkdir -p $url_config_base" purple;
println "mkdir -p $url_data_base" purple;
println "mkdir -p $url_path_base" purple;
println "mkdir -p ${url_path_base}tmp ${url_path_base}logs" purple;
println "chmod 777 ${url_path_base}tmp ${url_path_base}logs" purple;
fi
#安装CMAKE
if [ 1 = $ins_cmake ]; then
. ${url_software_base}fun/fun_ins_cmake.sh;
fun_ins_cmake;
fi
#安装MYSQL
if [ 1 = $ins_mysql ]; then
. ${url_software_base}fun/fun_ins_mysql.sh;
fun_ins_mysql;
fi
#安装PCRE
if [ 1 = $ins_pcre ]; then
. ${url_software_base}fun/fun_ins_pcre.sh;
fun_ins_pcre;
fi
#安装ZLIB
if [ 1 = $ins_zlib ]; then
. ${url_software_base}fun/fun_ins_zlib.sh;
fun_ins_zlib;
fi
#安装OPENSSL
if [ 1 = $ins_openssl ]; then
. ${url_software_base}fun/fun_ins_openssl.sh;
fun_ins_openssl;
fi
#安装NGINX
if [ 1 = $ins_nginx ]; then
. ${url_software_base}fun/fun_ins_nginx.sh;
fun_ins_nginx;
fi
#安装MHASH
if [ 1 = $ins_mhash ]; then
. ${url_software_base}fun/fun_ins_mhash.sh;
fun_ins_mhash;
fi
#安装LIBMCRYPT
if [ 1 = $ins_libmcrypt ]; then
. ${url_software_base}fun/fun_ins_libmcrypt.sh;
fun_ins_libmcrypt;
fi
#安装MCRYPT
if [ 1 = $ins_mcrypt ]; then
. ${url_software_base}fun/fun_ins_mcrypt.sh;
fun_ins_mcrypt;
fi
#安装BZIP2
if [ 1 = $ins_bzip2 ]; then
. ${url_software_base}fun/fun_ins_bzip2.sh;
fun_ins_bzip2;
fi
#安装PHP
if [ 1 = $ins_php ]; then
. ${url_software_base}fun/fun_ins_php.sh;
fun_ins_php;
fi
#安装REDIS
if [ 1 = $ins_redis ]; then
. ${url_software_base}fun/fun_ins_redis.sh;
fun_ins_redis;
fi
#安装PHP_MEMCACHE
if [ 1 = $ins_php_memcache ]; then
. ${url_software_base}fun/fun_ins_php_memcache.sh;
fun_ins_php_memcache;
fi
#安装MEMCACHE
if [ 1 = $ins_memcached ]; then
. ${url_software_base}fun/fun_ins_memcached.sh;
fun_ins_memcached;
fi
#安装LIBMEMCACHED
if [ 1 = $ins_libmemcached ]; then
. ${url_software_base}fun/fun_ins_libmemcached.sh;
fun_ins_libmemcached;
fi
#INSTALL APR
if [ 1 = $ins_apr ]; then
. ${url_software_base}fun/fun_ins_apr.sh;
fun_ins_apr;
fi
#INSTALL APR_UTIL
if [ 1 = $ins_apr_util ]; then
. ${url_software_base}fun/fun_ins_apr_util.sh;
fun_ins_apr_util;
fi
#INSTALL SQLITE
if [ 1 = $ins_sqlite ]; then
. ${url_software_base}fun/fun_ins_sqlite.sh;
fun_ins_sqlite;
fi
#INSTALL SCONS
if [ 1 = $ins_scons ]; then
. ${url_software_base}fun/fun_ins_scons.sh;
fun_ins_scons;
fi
#INSTALL SERF
if [ 1 = $ins_serf ]; then
. ${url_software_base}fun/fun_ins_serf.sh;
fun_ins_serf;
fi
#INSTALL SUBVERSION
if [ 1 = $ins_subversion ]; then
. ${url_software_base}fun/fun_ins_subversion.sh;
fun_ins_subversion;
fi
#安装PUREFTPD
if [ 1 = $ins_pureftpd ]; then
. ${url_software_base}fun/fun_ins_pureftpd.sh;
fun_ins_pureftpd;
fi
println "================================================================================" yellow;