#  Acs
## 注意事项
  - **mongodb 连接不支持账号密码**
  - **服务启动停止命令**
    - /etc/init.d/gzb-acs start
    - /etc/init.d/gzb-acs stop
## 配置文件路径
  - /home/ippbx/http/gzb-acs/config/config.json
  - **第一次安装时，请配置config.json文件的mongodb地址**

## 配套界面请安装GZB_Acs_Client

版本：GZB_ACS_V1.1.2
时间：2018-08-08
内容：
1. 增加设备tr069连接鉴权，并扩展到config.json配置中