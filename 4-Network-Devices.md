# Surveillance des périphériques réseau à l'aide d'ICMP Ping

- Installer et configurer fping

  - fping est un utilitaire que Zabbix utilise pour effectuer des contrôles ICMP (ping). Il est nécessaire à Zabbix pour surveiller les périphériques réseau sans avoir besoin d'un agent.

- Installe le package fping

```sh
sudo apt install fping -y
```

- Vérifie l'emplacement du binaire (généralement ).fping/usr/bin/fping

```sh
which fping
```

- Modifie la propriété du binaire à l' utilisateur et au groupe.fpingrootzabbix

```sh
chown root:zabbix /usr/bin/fping*
```

- Définit les autorisations afin que seuls l' utilisateur et les membres du groupe puissent exécuter .root zabbix fping

```sh
chmod 4710 /usr/bin/fping*
```

- Répertorie les autorisations du binaire pour confirmer qu'elles sont correctement définies.fping

```sh
ll /usr/bin/fping*
```

- Mettre à jour la configuration du serveur Zabbix

```sh
sudo nano /etc/zabbix/zabbix_server.conf
```

- Modifications de configuration

```sh
# Integrate FPING
StartPingers=10
FpingLocation=/usr/bin/fping
```

- **StartPingers=10** Configure Zabbix pour exécuter jusqu'à 10 processus de ping ICMP parallèles. Cela améliore les performances lors de la surveillance de plusieurs périphériques.
- **FpingLocation=/usr/bin/fping** Spécifie l'emplacement du binaire fping

- Redémarre le serveur Zabbix pour appliquer les modifications apportées à son fichier de configuration.

```sh
sudo systemctl restart zabbix-server
```

- Si les modifications apportées dans Zabbix (par exemple, l'ajout d'hôtes ou de modèles) ne prennent pas effet immédiatement, vous pouvez recharger le cache de configuration sans redémarrer les services

```sh
zabbix_server -R config_cache_reload
```

#### Étapes de l'interface Web

- Aller à: Configuration > Hosts > Create Host.
- Définir les détails de l'hôte

  - Host name: Entrez un nom pour votre appareil (par exemple, « Router01 »).
  - Groups: Attribuez-le à un groupe (par exemple, « Network Devices »).
  - Agent interfaces: Entrez l'adresse IP de l'appareil que vous souhaitez surveiller.

- Joindre un modèle de ping ICMP:

  - Accédez à Templates.
  - Cliquez sur Sélectionner , Template Module ICMP Ping.
  - Cliquez sur Add pour le joindre.

- Enregistrez vos modifications en cliquant sur Ajouter

#### 5. Vérifier la surveillance

- Après avoir ajouté un hôte, vérifiez que la surveillance fonctionne correctement
  - Aller à : .Monitoring > Latest Data
  - Sélectionnez votre hôte dans la liste.
  - Vérifiez les paramètres tels que :
    - ICMP ping: Disponibilité de l'appareil.
    - ICMP loss: Pourcentage de paquets perdus.
    - ICMP response time: Temps de réponse en millisecondes.
