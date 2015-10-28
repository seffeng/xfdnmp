##安装APR_UTIL
function fun_ins_apr_util(){
    println "\n================================================================================" yellow;
    println "-- INSTALL APR_UTIL [START]";
    ##是否调试模式
    apr_util_is_debug=${is_debug};
    apr_util_ins_prefix="${url_install_base}apr_util";
    apr_ins_prefix="${url_install_base}apr";
    if [ 0 = $apr_util_is_debug ]; then 
        if [ -d "${apr_util_ins_prefix}" ] ; then 
            println "-- APR_UTIL IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${apr_util_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    apr_util_shl=(
        "cd ${url_software_base}"
        "tar jxf ${apr_util_pack_name}"
        "cd ${apr_util_pack_folder}"
        "./configure --prefix=${apr_util_ins_prefix} --with-apr=${apr_ins_prefix}"
        "make"
        "make install"
    );
    apr_util_shl_len=${#apr_util_shl[*]};
    i=0;
    while [ $i -lt $apr_util_shl_len ]; do
        println "${apr_util_shl[$i]}" purple;
        if [ 0 = $apr_util_is_debug ]; then 
            shl_exec "${apr_util_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${apr_util_shl[$i]}""]" green;
            else
                println "ERROR [""${apr_util_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL APR_UTIL FINISH";
    println "================================================================================\n" yellow;
}