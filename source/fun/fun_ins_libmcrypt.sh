##安装libmcrypt
function fun_ins_libmcrypt(){
    println "\n================================================================================" yellow;
    println "-- INSTALL LIBMCRYPT [START]";
    ##是否调试模式
    libmcrypt_is_debug=${is_debug};
    libmcrypt_ins_prefix="${url_install_base}libmcrypt";
    if [ 0 = $libmcrypt_is_debug ]; then 
        if [ -d "${libmcrypt_ins_prefix}" ] ; then 
            println "-- LIBMCRYPT IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${libmcrypt_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    libmcrypt_shl=(
        "cd ${url_software_base}"
        "tar zxf ${libmcrypt_pack_name}"
        "cd ${libmcrypt_pack_folder}"
        "./configure --prefix=${libmcrypt_ins_prefix}"
        "make"
        "make install"
    );
    libmcrypt_shl_len=${#libmcrypt_shl[*]};
    i=0;
    while [ $i -lt $libmcrypt_shl_len ]; do
        println "${libmcrypt_shl[$i]}" purple;
        if [ 0 = $libmcrypt_is_debug ]; then 
            shl_exec "${libmcrypt_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${libmcrypt_shl[$i]}""]" green;
            else
                println "ERROR [""${libmcrypt_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL LIBMCRYPT FINISH";
    println "================================================================================\n" yellow;
}