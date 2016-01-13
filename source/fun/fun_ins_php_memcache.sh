##安装PHP_MEMCACHE
function fun_ins_php_memcache(){
    println "\n================================================================================" yellow;
    println "-- INSTALL PHP_MEMCACHE [START]";
    ##是否调试模式
    php_memcache_is_debug=${is_debug};
    php_ins_bin="${url_install_base}php/bin";
    ##依次命令
    php_memcache_shl=(
        "cd ${url_software_base}"
        "tar zxf ${php_memcache_pack_name}"
        "cd ${php_memcache_pack_folder}"
        "${php_ins_bin}/phpize"
        "./configure --enable-memcache --with-php-config=${php_ins_bin}/php-config --with-zlib-dir"
        "make"
        "make install"
    );
    php_memcache_shl_len=${#php_memcache_shl[*]};
    i=0;
    while [ $i -lt $php_memcache_shl_len ]; do
        println "${php_memcache_shl[$i]}" purple;
        if [ 0 = $php_memcache_is_debug ]; then 
            shl_exec "${php_memcache_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${php_memcache_shl[$i]}""]" green;
            else
                println "ERROR [""${php_memcache_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL PHP_MEMCACHE FINISH (Please modify file php.ini)";
    println "================================================================================\n" yellow;
}