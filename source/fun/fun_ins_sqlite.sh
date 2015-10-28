##安装SQLITE
function fun_ins_sqlite(){
    println "\n================================================================================" yellow;
    println "-- INSTALL SQLITE [START]";
    ##是否调试模式
    sqlite_is_debug=${is_debug};
    sqlite_ins_prefix="${url_install_base}sqlite";
    if [ 0 = $sqlite_is_debug ]; then 
        if [ -d "${sqlite_ins_prefix}" ] ; then 
            println "-- SQLITE IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${sqlite_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    sqlite_shl=(
        "cd ${url_software_base}"
        "tar zxf ${sqlite_pack_name}"
        "cd ${sqlite_pack_folder}"
        "./configure --prefix=${sqlite_ins_prefix}"
        "make"
        "make install"
    );
    sqlite_shl_len=${#sqlite_shl[*]};
    i=0;
    while [ $i -lt $sqlite_shl_len ]; do
        println "${sqlite_shl[$i]}" purple;
        if [ 0 = $sqlite_is_debug ]; then 
            shl_exec "${sqlite_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${sqlite_shl[$i]}""]" green;
            else
                println "ERROR [""${sqlite_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL SQLITE FINISH";
    println "================================================================================\n" yellow;
}