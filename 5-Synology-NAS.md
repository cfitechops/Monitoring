# Surveillance SNMP pour un NAS Synology

![Synology](/Zabbix-NAS-with-SNM/01.png)

![Synology](/Zabbix-NAS-with-SNM/02.png)

![Synology](/Zabbix-NAS-with-SNM/03.png)

![Synology](/Zabbix-NAS-with-SNM/04.png)

- Installer les packages SNMP

```sh
sudo apt install snmpd snmp libsnmp-dev -y
```

- Testez la connectivité SNMP avec snmpwalk

```sh
snmpwalk -v3 -a SHA -A auth_Password -x AES -X priv_Password -l authPriv -u admin <IP DE Synology> | head -10
```

![Synology](/Zabbix-NAS-with-SNM/05.png)

![Synology](/Zabbix-NAS-with-SNM/06.png)

![Synology](/Zabbix-NAS-with-SNM/07.png)

![Synology](/Zabbix-NAS-with-SNM/08.png)

![Synology](/Zabbix-NAS-with-SNM/09.png)

![Synology](/Zabbix-NAS-with-SNM/10.png)

![Synology](/Zabbix-NAS-with-SNM/11.png)

![Synology](/Zabbix-NAS-with-SNM/12.png)

![Synology](/Zabbix-NAS-with-SNM/13.png)

![Synology](/Zabbix-NAS-with-SNM/14.png)

![Synology](/Zabbix-NAS-with-SNM/15.png)

![Synology](/Zabbix-NAS-with-SNM/16.png)

![Synology](/Zabbix-NAS-with-SNM/17-1.png)

![Synology](/Zabbix-NAS-with-SNM/17-2.png)

![Synology](/Zabbix-NAS-with-SNM/18.png)

![Synology](/Zabbix-NAS-with-SNM/19.png)

#### Resources:

```sh
https://github.com/Synology/community-templates/tree/main/Storage_Devices/Synology/template_synology_diskstation_snmpv3
https://github.com/Synology/community-templates/blob/main/Storage_Devices/Synology/template_synology_diskstation_snmpv3/6.4/template_synology_diskstation_snmpv3.yaml
```
