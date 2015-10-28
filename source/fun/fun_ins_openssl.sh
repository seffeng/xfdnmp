##安装OPENSSL
function fun_ins_openssl(){
    println "\n================================================================================" yellow;
    println "-- INSTALL OPENSSL [START]";
    ##是否调试模式
    openssl_is_debug=${is_debug};
    openssl_ins_prefix="${url_install_base}openssl";
	if [ 0 = $openssl_is_debug ]; then 
		if [ -f "${openssl_ins_prefix}/bin/openssl" ] ; then 
			println "-- OPENSSL IS INSTALL";
			println "-- REINSTALL PLEASE DELETE [rm -rf ${openssl_ins_prefix}/bin/openssl]" red;
			return 0;
		fi
	fi
    ##依次命令
    openssl_shl=(
        "apt-get -y install perl"
        "cd ${url_software_base}"
        "tar zxf ${openssl_pack_name}"
        "cd ${openssl_pack_folder}"
        "./config --prefix=${openssl_ins_prefix}"
        "make"
        "make install"
    );
    openssl_shl_len=${#openssl_shl[*]};
    i=0;
    while [ $i -lt $openssl_shl_len ]; do
        println "${openssl_shl[$i]}" purple;
        if [ 0 = $openssl_is_debug ]; then 
            shl_exec "${openssl_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${openssl_shl[$i]}""]" green;
            else
                println "ERROR [""${openssl_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL OPENSSL FINISH";
    println "================================================================================\n" yellow;
}