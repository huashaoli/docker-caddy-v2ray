#!/usr/bin/env bash

pro_root_dir=$(cd "$(dirname "$(readlink -f $(which v2ray))")";pwd)/..

source ${pro_root_dir}/source/common_function.sh

####### 参数解析 #######
cmdname=$(basename $0)

# 操作参数
OPT=$1

# usage help doc.
usage() {
    cat << USAGE  >&2
Usage:
    $cmdname [ config[c] | modify[m] | update[u] | start[s] | stop[p] | restart[r] | help[h] ]
    [c] config      配置 V2Ray 和 Caddy
    [m] modify      修改 V2Ray 和 Caddy 配置
    [u] update      更新 V2Ray 和 Caddy 的 Docker 版本
    [s] start       启动 V2Ray 和 Caddy
    [p] stop        关闭 V2Ray 和 Caddy
    [r] restart     重启 V2Ray 和 Caddy
    [h] help        帮助文档
USAGE
exit 1
}

case $OPT in
    c | config)
        bash ${pro_root_dir}/util/v2ray-caddy-config.sh
        ;;
    m | modify)
        bash ${pro_root_dir}/util/v2ray-caddy-config.sh modify
        ;;
    u | update)
        git reset --hard
        git pull origin master

        docker_update
        docker_restart
        ;;
    s | start)
        docker_start
        ;;
    p | stop)
        docker_stop
        ;;
    r | restart)
        docker_restart
        ;;
    h | help )
        usage
        exit 1
        ;;
    \?)
        usage
        exit 1
        ;;
    *)
        usage
        exit 1
        ;;
esac

