##安装ZLIB
function fun_ins_zlib(){
    println "\n================================================================================" yellow;
    println "-- INSTALL ZLIB [START]";
    ##是否调试模式
    zlib_is_debug=${is_debug};
    zlib_ins_prefix="${url_install_base}zlib";
    if [ 0 = $zlib_is_debug ]; then 
        if [ -d "${zlib_ins_prefix}" ] ; then 
            println "-- ZLIB IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${zlib_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    zlib_shl=(
        "cd ${url_software_base}"
        "tar zxf ${zlib_pack_name}"
        "cd ${zlib_pack_folder}"
        "./configure --prefix=${zlib_ins_prefix}"
        "make"
        "make install"
    );
    zlib_shl_len=${#zlib_shl[*]};
    i=0;
    while [ $i -lt $zlib_shl_len ]; do
        println "${zlib_shl[$i]}" purple;
        if [ 0 = $zlib_is_debug ]; then 
            shl_exec "${zlib_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${zlib_shl[$i]}""]" green;
            else
                println "ERROR [""${zlib_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL ZLIB FINISH";
    println "================================================================================\n" yellow;
}