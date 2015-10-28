##安装BZIP2
function fun_ins_bzip2(){
    println "\n================================================================================" yellow;
    println "-- INSTALL BZIP2 [START]";
    ##是否调试模式
    bzip2_is_debug=${is_debug};
    ##依次命令
    bzip2_shl=(
        "cd ${url_software_base}"
        "tar zxf ${bzip2_pack_name}"
        "cd ${bzip2_pack_folder}"
        "make"
        "make install"
    );
    bzip2_shl_len=${#bzip2_shl[*]};
    i=0;
    while [ $i -lt $bzip2_shl_len ]; do
        println "${bzip2_shl[$i]}" purple;
        if [ 0 = $bzip2_is_debug ]; then 
            shl_exec "${bzip2_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${bzip2_shl[$i]}""]" green;
            else
                println "ERROR [""${bzip2_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL bzip2 FINISH";
    println "================================================================================\n" yellow;
}