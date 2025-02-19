# ZABBIX AGENT LINUX

- Mise à jour du système

```sh
sudo apt update && sudo apt upgrade -y
```

- Recherche du paquet Zabbix

```sh
sudo apt search zabbix
```

- Installation de Zabbix Agent
  - Zabbix Agent, qui collecte des données sur le serveur agent et les envoie au serveur Zabbix principal.

```sh
sudo apt install zabbix-agent -y
```

- Configuration de l'agent Zabbix

```sh
sudo nano /etc/zabbix/zabbix_agentd.conf
```

- Vous modifiez le fichier de configuration de l'agent Zabbix (/etc/zabbix/zabbix_agentd.conf) pour indiquer

```sh
Server=<IP ZABBIX SERVER>
ServerActive=<IP ZABBIX SERVER>
Hostname=<AGENT NAME>
```

- Rredémarre le service Zabbix Agent pour appliquer les modifications apportées au fichier de configuration.

```sh
sudo /etc/init.d/zabbix-agent restart
```

- Vérifier le statut du service

```sh
sudo systemctl status zabbix-agent.service
```

- Configurer le pare-feu (UFW)
  - Active le pare-feu UFW

```sh
sudo ufw enable
```

- Autoriser le port 10050

```sh
sudo ufw allow 10050
```

- Recharger UFW

```sh
sudo ufw reload
```

![linux](/assets/zabbix-linux/01.png)
