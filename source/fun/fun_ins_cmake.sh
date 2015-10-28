##安装CMAKE
function fun_ins_cmake(){
    println "\n================================================================================" yellow;
    println "-- INSTALL CMAKE [START]";
    ##是否调试模式
    cmake_is_debug=${is_debug};
    cmake_ins_prefix="${url_install_base}cmake";
    cmake_sbin_prefix="${url_sbin_base}cmake";
    if [ 0 = $cmake_is_debug ]; then 
        if [ -f "${cmake_ins_prefix}/bin/cmake" ] ; then 
            println "-- CMAKE IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${cmake_ins_prefix}/bin/cmake]" red;
            return 0;
        fi
    fi
    ##依次命令
    cmake_shl=(
        "cd ${url_software_base}"
        "tar zxf ${cmake_pack_name}"
        "cd ${cmake_pack_folder}"
        "./configure --prefix=${cmake_ins_prefix}"
        "make"
        "make install"
        "if [ -f "${cmake_sbin_prefix}" ] ; then (rm -rf ${cmake_sbin_prefix}) fi"
        "ln -s ${cmake_ins_prefix}/bin/cmake ${cmake_sbin_prefix}"
    );
    cmake_shl_len=${#cmake_shl[*]};
    i=0;
    while [ $i -lt $cmake_shl_len ]; do
        println "${cmake_shl[$i]}" purple;
        if [ 0 = $cmake_is_debug ]; then 
            if shl_exec "${cmake_shl[$i]}" ; then
                println "SUCCESS [""${cmake_shl[$i]}""]" green;
            else
                println "ERROR [""${cmake_shl[$i]}""]" red;
                shl_exit;
            fi
        fi
        let i++
    done
    println "-- INSTALL CMAKE FINISH";
    println "================================================================================\n" yellow;
}