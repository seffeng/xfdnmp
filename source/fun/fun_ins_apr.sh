##安装APR
function fun_ins_apr(){
    println "\n================================================================================" yellow;
    println "-- INSTALL APR [START]";
    ##是否调试模式
    apr_is_debug=${is_debug};
    apr_ins_prefix="${url_install_base}apr";
    if [ 0 = $apr_is_debug ]; then 
        if [ -d "${apr_ins_prefix}" ] ; then 
            println "-- APR IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${apr_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    apr_shl=(
        "cd ${url_software_base}"
        "tar zxf ${apr_pack_name}"
        "cd ${apr_pack_folder}"
        "./configure --prefix=${apr_ins_prefix}"
        "make"
        "make install"
    );
    apr_shl_len=${#apr_shl[*]};
    i=0;
    while [ $i -lt $apr_shl_len ]; do
        println "${apr_shl[$i]}" purple;
        if [ 0 = $apr_is_debug ]; then 
            shl_exec "${apr_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${apr_shl[$i]}""]" green;
            else
                println "ERROR [""${apr_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL APR FINISH";
    println "================================================================================\n" yellow;
}