##安装mhash
function fun_ins_mhash(){
    println "\n================================================================================" yellow;
    println "-- INSTALL MHASH [START]";
    ##是否调试模式
    mhash_is_debug=${is_debug};
    mhash_ins_prefix="${url_install_base}mhash";
    if [ 0 = $mhash_is_debug ]; then 
        if [ -d "${mhash_ins_prefix}" ] ; then 
            println "-- MHASH IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${mhash_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    mhash_shl=(
        "cd ${url_software_base}"
        "tar zxf ${mhash_pack_name}"
        "cd ${mhash_pack_folder}"
        "./configure --prefix=${mhash_ins_prefix}"
        "make"
        "make install"
    );
    mhash_shl_len=${#mhash_shl[*]};
    i=0;
    while [ $i -lt $mhash_shl_len ]; do
        println "${mhash_shl[$i]}" purple;
        if [ 0 = $mhash_is_debug ]; then 
            shl_exec "${mhash_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${mhash_shl[$i]}""]" green;
            else
                println "ERROR [""${mhash_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL MHASH FINISH";
    println "================================================================================\n" yellow;
}