##安装LIBMEMCACHED
function fun_ins_libmemcached(){
    println "\n================================================================================" yellow;
    println "-- INSTALL LIBMEMCACHED [START]";
    ##是否调试模式
    libmemcached_is_debug=${is_debug};
    libmemcached_ins_prefix="/usr/local/include/libmemcached/memcached.h";
    if [ 0 = $libmemcached_is_debug ]; then 
        if [ -f "${libmemcached_ins_prefix}" ] ; then 
            println "-- LIBMEMCACHED IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${libmemcached_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    libmemcached_shl=(
        "apt-get -y install libcloog-ppl0 libevent-dev"
        "cd ${url_software_base}"
        "tar zxf ${libmemcached_pack_name}"
        "cd ${libmemcached_pack_folder}"
        "./configure"
        "make"
        "make install"
    );
    libmemcached_shl_len=${#libmemcached_shl[*]};
    i=0;
    while [ $i -lt $libmemcached_shl_len ]; do
        println "${libmemcached_shl[$i]}" purple;
        if [ 0 = $libmemcached_is_debug ]; then 
            shl_exec "${libmemcached_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${libmemcached_shl[$i]}""]" green;
            else
                println "ERROR [""${libmemcached_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL LIBMEMCACHED FINISH";
    println "================================================================================\n" yellow;
}