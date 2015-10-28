##安装MYSQL
function fun_ins_mysql(){
    println "\n================================================================================" yellow;
    println "-- INSTALL MYSQL [START]";
    ##是否调试模式
    mysql_is_debug=${is_debug};
    mysql_ins_prefix="${url_install_base}mysql";
    mysql_config_folder="${url_config_base}mysql";
    mysql_ins_data="${url_data_base}mysql";
    mysql_ins_sock="${mysql_ins_data}/mysql.sock";
    mysql_sbin_prefix="${url_sbin_base}mysql";
    mysql_ins_user="mysql";
    mysql_ins_group="mysqls";
    mysql_defaut_port="3306";
    mysql_defaut_charset="utf8";
    mysql_defaut_collation="utf8_unicode_ci";
    if [ 0 = $mysql_is_debug ]; then 
        if [ -f "${mysql_ins_prefix}/bin/mysql" ] ; then 
            println "-- MYSQL IS INSTALL";
            println "-- REINSTALL PLEASE DELETE [rm -rf ${mysql_ins_prefix}/bin/mysql]" red;
            return 0;
        fi
    fi
    ##依次命令
    mysql_shl=(
        "apt-get -y install perl libncurses5-dev libmysqlclient-dev"
        "cd ${url_software_base}"
        "tar zxf ${mysql_pack_name}"
        "cd ${mysql_pack_folder}"
        "mkdir -p ${mysql_config_folder}"
        "groups ${mysql_ins_user} > /dev/null 2>&1 || groupadd ${mysql_ins_group}"
        "id ${mysql_ins_user} > /dev/null 2>&1 || useradd -M -s /sbin/nologin -g ${mysql_ins_group} ${mysql_ins_user}"
        "if [ -f "/etc/mysql/my.cnf" ] ; then (mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak) fi"
        "if [ ! -d "${mysql_ins_prefix}" ] ; then (mkdir ${mysql_ins_prefix}) fi"
        "if [ ! -d "${mysql_ins_data}" ] ; then (mkdir ${mysql_ins_data}) fi"
        "chown -R ${mysql_ins_user}:${mysql_ins_group} ${mysql_ins_data}"
        "cmake -DCMAKE_INSTALL_PREFIX=${mysql_ins_prefix} -DSYSCONFDIR=${mysql_config_folder} -DMYSQL_UNIX_ADDR=${mysql_ins_sock} -DMYSQL_DATADIR=${mysql_ins_data} -DMYSQL_USER=${mysql_ins_user} -DDEFAULT_CHARSET=${mysql_defaut_charset} -DMYSQL_TCP_PORT=${mysql_defaut_port} -DDEFAULT_COLLATION=${mysql_defaut_collation} -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DWITH_EXTRA_CHARSETS:STRING=all"
        "make"
        "make install"
        "cp -f ./support-files/mysql.server /etc/init.d/mysqld"
        "chmod 755 /etc/init.d/mysqld"
        "chmod 755 ./scripts/mysql_install_db"
        "./scripts/mysql_install_db --user=${mysql_ins_user} --basedir=${mysql_ins_prefix} --datadir=${mysql_ins_data}"
        "cp -f ./support-files/my-medium.cnf ${mysql_config_folder}/my.cnf"
        "chmod 0644 ${mysql_config_folder}/my.cnf"
        "if [ -f "${mysql_sbin_prefix}" ] ; then (rm -rf ${mysql_sbin_prefix}) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysql ${mysql_sbin_prefix}"
        "if [ -f "${url_sbin_base}msql2mysql" ] ; then (rm -rf ${url_sbin_base}msql2mysql) fi"
        "ln -s ${mysql_ins_prefix}/bin/msql2mysql ${url_sbin_base}msql2mysql"
        "if [ -f "${url_sbin_base}mysqlaccess" ] ; then (rm -rf ${url_sbin_base}mysqlaccess) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlaccess ${url_sbin_base}mysqlaccess"
        "if [ -f "${url_sbin_base}mysqladmin" ] ; then (rm -rf ${url_sbin_base}mysqladmin) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqladmin ${url_sbin_base}mysqladmin"
        "if [ -f "${url_sbin_base}mysqlbinlog" ] ; then (rm -rf ${url_sbin_base}mysqlbinlog) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlbinlog ${url_sbin_base}mysqlbinlog"
        "if [ -f "${url_sbin_base}mysqlcheck" ] ; then (rm -rf ${url_sbin_base}mysqlcheck) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlcheck ${url_sbin_base}mysqlcheck"
        "if [ -f "${url_sbin_base}mysql_config" ] ; then (rm -rf ${url_sbin_base}mysql_config) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysql_config ${url_sbin_base}mysql_config"
        "if [ -f "${url_sbin_base}mysqldump" ] ; then (rm -rf ${url_sbin_base}mysqldump) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqldump ${url_sbin_base}mysqldump"
        "if [ -f "${url_sbin_base}mysql_find_rows" ] ; then (rm -rf ${url_sbin_base}mysql_find_rows) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysql_find_rows ${url_sbin_base}mysql_find_rows"
        "if [ -f "${url_sbin_base}mysqlimport" ] ; then (rm -rf ${url_sbin_base}mysqlimport) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlimport ${url_sbin_base}mysqlimport"
        "if [ -f "${url_sbin_base}mysqlshow" ] ; then (rm -rf ${url_sbin_base}mysqlshow) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlshow ${url_sbin_base}mysqlshow"
        "if [ -f "${url_sbin_base}mysqlslap" ] ; then (rm -rf ${url_sbin_base}mysqlslap) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysqlslap ${url_sbin_base}mysqlslap"
        "if [ -f "${url_sbin_base}mysql_waitpid" ] ; then (rm -rf ${url_sbin_base}mysql_waitpid) fi"
        "ln -s ${mysql_ins_prefix}/bin/mysql_waitpid ${url_sbin_base}mysql_waitpid"
    );
    mysql_shl_len=${#mysql_shl[*]};
    i=0;
    while [ $i -lt $mysql_shl_len ]; do
        println "${mysql_shl[$i]}" purple;
        if [ 0 = $mysql_is_debug ]; then 
            shl_exec "${mysql_shl[$i]}";
            if [ $? -eq 0 ] ; then
                println "SUCCESS [""${mysql_shl[$i]}""]" green;
            else
                println "ERROR [""${mysql_shl[$i]}""]" red;
                echo $?;
                shl_exit;
            fi
            echo $?;
        fi
        let i++
    done
    println "-- INSTALL MYSQL FINISH";
    println "================================================================================\n" yellow;
}