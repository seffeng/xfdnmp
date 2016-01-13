##安装SERF
function fun_ins_serf(){
    println "\n================================================================================" yellow;
    println "-- INSTALL SERF [START]";
    ##是否调试模式
    serf_is_debug=${is_debug};
    scons_ins_prefix="${url_software_base}${scons_pack_folder}/";
    apr_ins_prefix="${url_install_base}apr";
    apr_util_ins_prefix="${url_install_base}apr_util";
    openssl_ins_prefix="${url_install_base}openssl";
    serf_ins_prefix="${url_install_base}serf";
    if [ 0 = $serf_is_debug ]; then 
        if [ -d "${serf_ins_prefix}" ] ; then 
            println "-- SERF IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${serf_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    serf_shl=(
        "apt-get -y install libssl-dev"
        "cd ${url_software_base}"
        "tar jxf ${serf_pack_name}"
        "cd ${serf_pack_folder}"
        "${scons_ins_prefix}scons.py APR=${apr_ins_prefix}/bin/apr-1-config APU=${apr_util_ins_prefix}/bin/apu-1-config OPENSSL=${openssl_ins_prefix}/ssl/"
        "${scons_ins_prefix}scons.py PREFIX=${serf_ins_prefix} install"
        "if [ -f "/lib/libserf-1.so.1" ] ; then (rm -rf /lib/libserf-1.so.1) fi"
        "ln -s ${serf_ins_prefix}/lib/libserf-1.so.1 /lib/libserf-1.so.1"
        "if [ -f "/lib/libserf-1.so" ] ; then (rm -rf /lib/libserf-1.so) fi"
        "ln -s ${serf_ins_prefix}/lib/libserf-1.so /lib/libserf-1.so"
        "ldconfig"
    );
    serf_shl_len=${#serf_shl[*]};
    i=0;
    while [ $i -lt $serf_shl_len ]; do
        println "${serf_shl[$i]}" purple;
        if [ 0 = $serf_is_debug ]; then 
            shl_exec "${serf_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${serf_shl[$i]}""]" green;
            else
                println "ERROR [""${serf_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL SERF FINISH";
    println "================================================================================\n" yellow;
}