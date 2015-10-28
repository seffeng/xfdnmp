##安装REDIS
function fun_ins_redis(){
    println "\n================================================================================" yellow;
    println "-- INSTALL REDIS [START]";
    ##是否调试模式
    redis_is_debug=${is_debug};
    redis_ins_prefix="${url_install_base}redis";
    redis_conf_folder="${url_config_base}redis";
    if [ 0 = $redis_is_debug ]; then 
        if [ -d "${redis_ins_prefix}" ] ; then 
            println "-- REDIS IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${redis_ins_prefix}]" red;
            return 0;
        fi
    fi
    ##依次命令
    redis_shl=(
        "cd ${url_software_base}"
        "tar zxf ${redis_pack_name}"
        "cp -R ${redis_pack_folder} ${redis_ins_prefix}"
        "cd ${redis_ins_prefix}"
        "mkdir -p ${redis_conf_folder}"
        "make"
        "make install"
        "if [ ! -f ${redis_conf_folder}/redis.conf ] ; then (cp -f ${redis_ins_prefix}/redis.conf ${redis_conf_folder}/redis.conf) fi"
        "echo -e '#/bin/sh/\n${redis_ins_prefix}/src/redis-server ${redis_conf_folder}/redis.conf'>${redis_conf_folder}/start.sh"
        "echo -e '#/bin/sh/\nkill -s 9 \`cat ${url_path_base}tmp/redis.pid\`'>${redis_conf_folder}/stop.sh"
        "chmod +x ${redis_conf_folder}/start.sh ${redis_conf_folder}/stop.sh"
    );
    redis_shl_len=${#redis_shl[*]};
    i=0;
    while [ $i -lt $redis_shl_len ]; do
        println "${redis_shl[$i]}" purple;
        if [ 0 = $redis_is_debug ]; then 
            shl_exec "${redis_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${redis_shl[$i]}""]" green;
            else
                println "ERROR [""${redis_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL REDIS FINISH";
    println "================================================================================\n" yellow;
}