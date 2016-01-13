##安装SCONS
function fun_ins_scons(){
    println "\n================================================================================" yellow;
    println "-- INSTALL SCONS [START]";
    ##是否调试模式
    scons_is_debug=${is_debug};
    scons_ins_prefix="${url_software_base}${scons_pack_folder}";
    if [ 0 = $scons_is_debug ]; then 
        if [ -d "${scons_ins_prefix}" ] ; then 
            println "-- SCONS IS UNCOMPRESSION";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${scons_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    scons_shl=(
        "apt-get -y install python"
        "cd ${url_software_base}"
        "tar zxf ${scons_pack_name}"
    );
    scons_shl_len=${#scons_shl[*]};
    i=0;
    while [ $i -lt $scons_shl_len ]; do
        println "${scons_shl[$i]}" purple;
        if [ 0 = $scons_is_debug ]; then 
            shl_exec "${scons_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${scons_shl[$i]}""]" green;
            else
                println "ERROR [""${scons_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL SCONS FINISH";
    println "================================================================================\n" yellow;
}