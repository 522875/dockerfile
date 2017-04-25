##目前支持的系统名称有

  - 开放平台 kop
  - 知店 zd, zdui, zdc, zdkf
  - 知店运营后台 zdop, zdopui
  - 大后台商户管理 backend, backendui
  - 大后台权限系统 auth, authui
  - 大后台活动配置 hdpz, hdpzui
  - 大后台分润系统 profit, profitui

##获取所有Key内容

curl -v http://ab.local.kashuo.net:8080/ab/get_all?system=zd

##设置UID跳转

curl -v http://ab.local.kashuo.net:8080/ab/set?system=zd&uid=1111&upstream=http://10.1.1.2:8081

参数： system, uid, upstream

其中upstream需要带前缀http://


#获取UID内容

curl -v http://ab.local.kashuo.net:8080/ab/get?system=zd&uid=1111

#删除所有UID

curl -v http://ab.local.kashuo.net:8080/ab/del_all?system=zd


# NGINX CONF  http配置增加
    lua_package_path "/opt/openresty/nginx/?.lua;;";
    include "/opt/openresty/nginx/abtesting/confd/*.conf";

# 项目配置样例
    location / { 
        set $system_name "kop-server";
        set $proxy_url http://kop-server;
        rewrite_by_lua_file "abtesting/route/route.lua";
        proxy_pass $proxy_url;
    }