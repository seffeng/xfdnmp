##安装PUREFTPD
function fun_ins_pureftpd(){
    println "\n================================================================================" yellow;
    println "-- INSTALL PUREFTPD [START]";
    ##是否调试模式
    pureftpd_is_debug=${is_debug};
    pureftpd_ins_prefix="${url_install_base}pureftpd";
    pureftpd_config_folder="${url_config_base}pureftpd";
    pureftpd_ssl_folder="${pureftpd_config_folder}/ssl";
    pureftpd_etc_folder="${pureftpd_config_folder}/etc";
    pureftpd_sbin_prefix="/usr/local/sbin/pure-ftpd";
    if [ 0 = $pureftpd_is_debug ]; then 
        if [ -d "${pureftpd_ins_prefix}" ] ; then 
            println "-- PUREFTPD IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${pureftpd_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    pureftpd_shl=(
        "rm -f /usr/lib/libmysql* && ln -s ${url_install_base}mysql/lib/libmysql* /usr/lib/"
        "if [ -d "/usr/lib64/" ] ; then (rm -f /usr/lib64/libmysql* && ln -s ${url_install_base}mysql/lib/libmysql* /usr/lib64/) fi"
        "mkdir -p ${pureftpd_etc_folder}"
        "mkdir -p ${pureftpd_config_folder}"
        "cd ${url_software_base}"
        "tar jxf ${pureftpd_pack_name}"
        "cd ${pureftpd_pack_folder}"
        "./configure --prefix=${pureftpd_ins_prefix} --with-mysql --with-puredb --with-paranoidmsg --with-peruserlimits --with-shadow --with-welcomemsg --with-uploadscript --with-quotas --with-cookie --with-virtualhosts --with-virtualchroot --with-diraliases --with-sysquotas --with-ratios --with-ftpwho --with-throttling --with-language=english --with-altlog --with-iplogging --without-usernames"
        "make"
        "make install"
        "if [ ! -f "${pureftpd_etc_folder}/pure-ftpd.conf" ] ; then (cp -f configuration-file/pure-ftpd.conf ${pureftpd_etc_folder}/pure-ftpd.conf) fi"
        "if [ ! -f "${pureftpd_etc_folder}/pureftpd-mysql.conf" ] ; then (cp -f pureftpd-mysql.conf ${pureftpd_etc_folder}/pureftpd-mysql.conf) fi"
        "cp -f configuration-file/pure-config.pl ${pureftpd_config_folder}/pure-config.pl"
        "if [ -f "${pureftpd_sbin_prefix}" ] ; then (rm -rf ${pureftpd_sbin_prefix}) fi"
        "ln -s ${pureftpd_ins_prefix}/sbin/pure-ftpd ${pureftpd_sbin_prefix}"
        "chmod +x ${pureftpd_config_folder}/pure-config.pl"
        "echo -e '#!/bin/sh\n${pureftpd_config_folder}/pure-config.pl ${pureftpd_etc_folder}/pure-ftpd.conf > /dev/null &'>${pureftpd_config_folder}/start.sh"
        "chmod +x ${pureftpd_config_folder}/start.sh"
    );
    pureftpd_shl_len=${#pureftpd_shl[*]};
    i=0;
    while [ $i -lt $pureftpd_shl_len ]; do
        println "${pureftpd_shl[$i]}" purple;
        if [ 0 = $pureftpd_is_debug ]; then 
            shl_exec "${pureftpd_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${pureftpd_shl[$i]}""]" green;
            else
                println "ERROR [""${pureftpd_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL PUREFTPD FINISH";
    println "================================================================================\n" yellow;
}