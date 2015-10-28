##安装MEMCACHED
function fun_ins_memcached(){
    println "\n================================================================================" yellow;
    println "-- INSTALL MEMCACHED [START]";
    ##是否调试模式
    memcache_is_debug=${is_debug};
    memcache_etc_folder="${url_config_base}memcached";
    memcache_ins_prefix="${url_install_base}memcached";
    memcache_ins_group="memcaches";
    memcache_ins_user="memcache";
    if [ 0 = $memcache_is_debug ]; then 
        if [ -d "${memcache_ins_prefix}" ] ; then 
            println "-- MEMCACHED IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${memcache_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    memcache_shl=(
        "apt-get -y install libevent-dev"
        "cd ${url_software_base}"
        "tar zxf ${memcache_pack_name}"
        "cd ${memcache_pack_folder}"
        "mkdir -p ${memcache_etc_folder}"
        "./configure --prefix=${memcache_ins_prefix}"
        "make"
        "make install"
        "if [ -f "${url_sbin_base}memcached" ] ; then (rm -rf ${url_sbin_base}memcached) fi"
        "ln -s ${memcache_ins_prefix}/bin/memcached ${url_sbin_base}memcached"
        "mkdir -p ${memcache_etc_folder}"
        "groups ${memcache_ins_group} > /dev/null 2>&1 || groupadd ${memcache_ins_group}"
        "id ${memcache_ins_user} > /dev/null 2>&1 || useradd -M -s /sbin/nologin -g ${memcache_ins_group} ${memcache_ins_user}"
        "echo -e '#!/bin/sh\n${url_sbin_base}memcached -d -m 512 -u www -l 127.0.0.1 -p 0 -c 10000 -P ${memcache_etc_folder}/memcached.pid -s ${memcache_etc_folder}/memcached.sock'>${memcache_etc_folder}/start.sh"
        "echo -e '#!/bin/sh\nkill -s 9 \`cat ${url_path_base}tmp/memcached.pid\`'>${memcache_etc_folder}/stop.sh"
        "chmod +x ${memcache_etc_folder}/start.sh ${memcache_etc_folder}/stop.sh"
        "chown -R ${memcache_ins_user}:${memcache_ins_group} ${memcache_etc_folder}"
    );
    memcache_shl_len=${#memcache_shl[*]};
    i=0;
    while [ $i -lt $memcache_shl_len ]; do
        println "${memcache_shl[$i]}" purple;
        if [ 0 = $memcache_is_debug ]; then 
            shl_exec "${memcache_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${memcache_shl[$i]}""]" green;
            else
                println "ERROR [""${memcache_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL MEMCACHED FINISH";
    println "Use: ${url_sbin_base}memcached -d -m 512 -u www -l 127.0.0.1 -p 0 -c 10000 -P ${memcache_etc_folder}/memcached.pid -s ${memcache_etc_folder}/memcached.sock";
    println "================================================================================\n" yellow;
}