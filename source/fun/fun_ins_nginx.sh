##安装NGINX
function fun_ins_nginx(){
    println "\n================================================================================" yellow;
    println "-- INSTALL NGINX [START]";
    ##是否调试模式
    nginx_is_debug=${is_debug};
    nginx_ins_prefix="${url_install_base}nginx";
    pcre_ins_source="${url_software_base}${pcre_pack_folder}";
    openssl_ins_source="${url_software_base}${openssl_pack_folder}";
    zlib_ins_source="${url_software_base}${zlib_pack_folder}";
    nginx_ins_group="wwww";
    nginx_ins_user="www";
    nginx_conf_folder="${url_config_base}nginx";
    nginx_logs_folder="${nginx_conf_folder}/logs";
    nginx_confs_file="${nginx_conf_folder}/nginx.conf";
    nginx_sbin_prefix="${url_sbin_base}nginx";
    if [ 0 = $nginx_is_debug ]; then 
        if [ -f "${nginx_ins_prefix}/sbin/nginx" ] ; then 
            println "-- NGINX IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${nginx_ins_prefix}/sbin/nginx]" red;
            return 0;
        fi
    fi
    ##依次命令
    nginx_shl=(
        "cd ${url_software_base}"
        "tar zxf ${nginx_pack_name}"
        "cd ${nginx_pack_folder}"
        "mkdir -p ${nginx_logs_folder}"
        "./configure --prefix=${nginx_ins_prefix} --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-ipv6 --with-mail --with-mail_ssl_module --with-pcre=${pcre_ins_source} --with-openssl=${openssl_ins_source} --with-zlib=${zlib_ins_source} --conf-path=${nginx_confs_file} --group=${nginx_ins_group} --user=${nginx_ins_user} --error-log-path=${nginx_logs_folder}/error.log --http-log-path=${nginx_logs_folder}/access.log --pid-path=${nginx_conf_folder}/pid.txt --lock-path=${nginx_conf_folder}/lock.txt"
        "make"
        "make install"
        "groups ${nginx_ins_user} > /dev/null 2>&1 || groupadd ${nginx_ins_group}"
        "id ${nginx_ins_user} > /dev/null 2>&1 || useradd -M -s /sbin/nologin -g ${nginx_ins_group} ${nginx_ins_user}"
        "if [ -f "${nginx_sbin_prefix}" ] ; then (rm -rf ${nginx_sbin_prefix}) fi"
        "ln -s ${nginx_ins_prefix}/sbin/nginx ${nginx_sbin_prefix}"
    );
    nginx_shl_len=${#nginx_shl[*]};
    i=0;
    while [ $i -lt $nginx_shl_len ]; do
        println "${nginx_shl[$i]}" purple;
        if [ 0 = $nginx_is_debug ]; then 
            shl_exec "${nginx_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${nginx_shl[$i]}""]" green;
            else
                println "ERROR [""${nginx_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL NGINX FINISH";
    println "================================================================================\n" yellow;
}
