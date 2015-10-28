##安装MCRYPT
function fun_ins_mcrypt(){
    println "\n================================================================================" yellow;
    println "-- INSTALL MCRYPT [START]";
    ##是否调试模式
    mcrypt_is_debug=${is_debug};
    mcrypt_ins_prefix="${url_install_base}mcrypt";
    if [ 0 = $mcrypt_is_debug ]; then 
        if [ -d "${mcrypt_ins_prefix}" ] ; then 
            println "-- MCRYPT IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${mcrypt_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    mcrypt_shl=(
        "cd ${url_software_base}"
        "tar zxf ${mcrypt_pack_name}"
        "cd ${mcrypt_pack_folder}"
        "export LD_LIBRARY_PATH=${url_install_base}libmcrypt/lib:${url_install_base}mhash/lib"
        "export LDFLAGS=\"-L${url_install_base}mhash/lib/ -I${url_install_base}mhash/include/\""
        "export CFLAGS=\"-I${url_install_base}mhash/include/\""
        "./configure --prefix=${mcrypt_ins_prefix} --with-libmcrypt-prefix=${url_install_base}libmcrypt"
        "make"
        "make install"
    );
    mcrypt_shl_len=${#mcrypt_shl[*]};
    i=0;
    while [ $i -lt $mcrypt_shl_len ]; do
        println "${mcrypt_shl[$i]}" purple;
        if [ 0 = $mcrypt_is_debug ]; then 
            shl_exec "${mcrypt_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${mcrypt_shl[$i]}""]" green;
            else
                println "ERROR [""${mcrypt_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL MCRYPT FINISH";
    println "================================================================================\n" yellow;
}