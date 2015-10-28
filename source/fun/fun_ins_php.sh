##安装PHP
function fun_ins_php(){
    println "\n================================================================================" yellow;
    println "-- INSTALL PHP(PHP-FPM) [START]";
    ##是否调试模式
    php_is_debug=${is_debug};
    php_ins_prefix="${url_install_base}php";
    php_etc_folder="${url_config_base}php";
    php_log_folder="${php_etc_folder}/log";
    php_sbin_prefix="${url_sbin_base}php";
    if [ 0 = $php_is_debug ]; then 
        if [ -f "${php_ins_prefix}/bin/php" ] ; then 
            println "-- PHP(PHP-FPM) IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${php_ins_prefix}/bin/php]" red;
            return 0;
        fi
    fi
    ##依次命令
    php_shl=(
        "apt-get -y install libxml2-dev curl libcurl4-openssl-dev libjpeg62-turbo-dev libpng12-dev libfreetype6-dev libevent-dev libmysqlclient-dev autoconf"
        "cd ${url_software_base}"
        "tar jxf ${php_pack_name}"
        "cd ${php_pack_folder}"
        "mkdir -p ${php_log_folder}"
        "./configure --prefix=${php_ins_prefix} --enable-fpm --with-fpm-user=www --with-fpm-group=wwww --with-config-file-path=${php_etc_folder} --enable-ftp --enable-zip --enable-sockets --enable-soap --enable-pcntl --enable-mbstring --enable-calendar --enable-exif --with-gd --with-curl --with-jpeg-dir --with-png-dir --with-openssl=${url_install_base}openssl --with-zlib --with-zlib-dir=${url_install_base}zlib --with-xmlrpc --with-libxml-dir --with-freetype-dir --with-mcrypt=${url_install_base}libmcrypt --with-bz2 --with-pdo-mysql=mysqlnd --with-mysql=${url_install_base}mysql --with-mysqli=${url_install_base}mysql/bin/mysql_config"
        "make"
        "make install"
        "if [ ! -f "${php_etc_folder}/php.ini" ] ; then (cp php.ini-development ${php_etc_folder}/php.ini) fi"
        "if [ ! -f "${php_ins_prefix}/etc/php-fpm.conf" ] ; then (cp sapi/fpm/php-fpm.conf ${php_ins_prefix}/etc/php-fpm.conf) fi"
        "if [ ! -f "${php_etc_folder}/php-fpm.conf" ] ; then (cp ${php_ins_prefix}/etc/php-fpm.conf ${php_etc_folder}/php-fpm.conf) fi"
        "if [ -f "${php_sbin_prefix}" ] ; then (rm -rf ${php_sbin_prefix}) fi"
        "ln -s ${php_ins_prefix}/bin/php ${php_sbin_prefix}"
        "if [ -f "${url_sbin_base}phpize" ] ; then (rm -rf ${url_sbin_base}phpize) fi"
        "ln -s ${php_ins_prefix}/bin/phpize ${url_sbin_base}phpize"
        "if [ -f "${url_sbin_base}php-fpm" ] ; then (rm -rf ${url_sbin_base}php-fpm) fi"
        "echo -e '#!/bin/sh\n${php_ins_prefix}/sbin/php-fpm -y ${php_etc_folder}/php-fpm.conf \$1' > ${php_etc_folder}/start.sh"
        "echo -e '#/bin/sh/\nkill -INT  \`cat ${php_log_folder}/php-fpm.pid\`'>${php_etc_folder}/stop.sh"
        "echo -e '#/bin/sh/\nkill -USR2  \`cat ${php_log_folder}/php-fpm.pid\`'>${php_etc_folder}/reload.sh"
        "chmod +x ${php_etc_folder}/start.sh ${php_etc_folder}/stop.sh ${php_etc_folder}/reload.sh"
        "ln -s ${php_etc_folder}/start.sh ${url_sbin_base}php-fpm"
    );
    php_shl_len=${#php_shl[*]};
    i=0;
    while [ $i -lt $php_shl_len ]; do
        println "${php_shl[$i]}" purple;
        if [ 0 = $php_is_debug ]; then 
            shl_exec "${php_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${php_shl[$i]}""]" green;
            else
                println "ERROR [""${php_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL PHP(PHP-FPM) FINISH";
    println "================================================================================\n" yellow;
}
