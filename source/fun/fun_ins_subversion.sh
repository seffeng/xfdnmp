##安装SUBVERSION
function fun_ins_subversion(){
    println "\n================================================================================" yellow;
    println "-- INSTALL SUBVERSION [START]";
    ##是否调试模式
    subversion_is_debug=${is_debug};
    subversion_ins_prefix="${url_install_base}subversion";
    subversion_conf_folder="${url_config_base}subversion";
    apr_ins_prefix="${url_install_base}apr";
    apr_util_ins_prefix="${url_install_base}apr_util";
    sqlite_ins_prefix="${url_install_base}sqlite";
    serf_ins_prefix="${url_install_base}serf";
    if [ 0 = $subversion_is_debug ]; then 
        if [ -d "${subversion_ins_prefix}" ] ; then 
            println "-- SUBVERSION IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${subversion_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    subversion_shl=(
        "apt-get -y install python"
        "cd ${url_software_base}"
        "tar jxf ${subversion_pack_name}"
        "cd ${subversion_pack_folder}"
        "mkdir -p ${subversion_conf_folder}"
        "./configure --prefix=${subversion_ins_prefix} --sysconfdir=${subversion_conf_folder} --with-apr=${apr_ins_prefix} --with-apr-util=${apr_util_ins_prefix} --with-sqlite=${sqlite_ins_prefix} --with-serf=${serf_ins_prefix}"
        "make"
        "make install"
        "echo -e '#!/bin/sh\n${subversion_ins_prefix}/bin/svnserve -d --listen-port 6868 -r ${subversion_conf_folder}/data --log-file=${url_path_base}logs/subversion.log --pid-file=${url_path_base}tmp/subversion.pid'>${subversion_conf_folder}/start.sh"
        "echo -e '#!/bin/sh\nkill -s 9 \`cat ${url_path_base}tmp/subversion.pid\`'>${subversion_conf_folder}/stop.sh"
        "chmod +x ${subversion_conf_folder}/start.sh ${subversion_conf_folder}/stop.sh"
        "if [ -f "/usr/local/bin/svn" ] ; then (rm -rf /usr/local/bin/svn) fi"
        "ln -s ${subversion_ins_prefix}/bin/svn /usr/local/bin/svn"
        "if [ -f "/usr/local/bin/svnadmin" ] ; then (rm -rf /usr/local/bin/svnadmin) fi"
        "ln -s ${subversion_ins_prefix}/bin/svnadmin /usr/local/bin/svnadmin"
        "if [ -f "/usr/local/bin/svndumpfilter" ] ; then (rm -rf /usr/local/bin/svndumpfilter) fi"
        "ln -s ${subversion_ins_prefix}/bin/svndumpfilter /usr/local/bin/svndumpfilter"
        "if [ -f "/usr/local/bin/svnlook" ] ; then (rm -rf /usr/local/bin/svnlook) fi"
        "ln -s ${subversion_ins_prefix}/bin/svnlook /usr/local/bin/svnlook"
        "if [ -f "/usr/local/bin/svnrdump" ] ; then (rm -rf /usr/local/bin/svnrdump) fi"
        "ln -s ${subversion_ins_prefix}/bin/svnrdump /usr/local/bin/svnrdump"
        "if [ -f "/usr/local/bin/svnserve" ] ; then (rm -rf /usr/local/bin/svnserve) fi"
        "ln -s ${subversion_ins_prefix}/bin/svnserve /usr/local/bin/svnserve"
        "if [ -f "/usr/local/bin/svnsync" ] ; then (rm -rf /usr/local/bin/svnsync) fi"
        "ln -s ${subversion_ins_prefix}/bin/svnsync /usr/local/bin/svnsync"
    );
    subversion_shl_len=${#subversion_shl[*]};
    i=0;
    while [ $i -lt $subversion_shl_len ]; do
        println "${subversion_shl[$i]}" purple;
        if [ 0 = $subversion_is_debug ]; then 
            shl_exec "${subversion_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${subversion_shl[$i]}""]" green;
            else
                println "ERROR [""${subversion_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL SUBVERSION FINISH";
    println "================================================================================\n" yellow;
}