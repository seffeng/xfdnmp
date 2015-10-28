##安装PCRE
function fun_ins_pcre(){
    println "\n================================================================================" yellow;
    println "-- INSTALL PCRE [START]";
    ##是否调试模式
    pcre_is_debug=${is_debug};
    pcre_ins_prefix="${url_install_base}pcre";
    if [ 0 = $pcre_is_debug ]; then 
        if [ -d "${pcre_ins_prefix}" ] ; then 
            println "-- PCRE IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${pcre_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    pcre_shl=(
        "apt-get -y install libpcre3-dev"
        "cd ${url_software_base}"
        "tar jxf ${pcre_pack_name}"
        "cd ${pcre_pack_folder}"
        "./configure --prefix=${pcre_ins_prefix}"
        "make"
        "make install"
    );
    pcre_shl_len=${#pcre_shl[*]};
    i=0;
    while [ $i -lt $pcre_shl_len ]; do
        println "${pcre_shl[$i]}" purple;
        if [ 0 = $pcre_is_debug ]; then 
            shl_exec "${pcre_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${pcre_shl[$i]}""]" green;
            else
                println "ERROR [""${pcre_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL PCRE FINISH";
    println "================================================================================\n" yellow;
}