#### ZABBIX SERVER

- Est une plateforme de supervision qui permet de surveiller les performances et la disponibilité de vos serveurs, applications, réseaux, etc.

- Mise à jour du système

```sh
sudo apt update && sudo apt upgrade -y
```

- Téléchargement du dépôt Zabbix

```sh
sudo wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_6.4+ubuntu22.04_all.deb
```

- Installation du dépôt Zabbix

```sh
sudo dpkg -i zabbix-release_latest_6.4+ubuntu22.04_all.deb
```

- Mettez à jour la liste des paquets pour inclure ceux de Zabbix

```sh
sudo apt update
```

- Installation des composants Zabbix

```sh
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```

- **zabbix-server-mysql** : Le serveur Zabbix, qui utilise MySQL comme base de données.
- **zabbix-frontend-php** : L’interface web de Zabbix (en PHP).
- **zabbix-apache-conf** : Les fichiers de configuration pour Apache (le serveur web).
- **zabbix-sql-scripts** : Les scripts SQL nécessaires pour configurer la base de données.
- **zabbix-agent** : L’agent Zabbix, qui collecte les données sur le serveur où il est installé.

- Installation de MySQL, qui sera utilisé comme base de données pour stocker les informations collectées par Zabbix.

```sh
sudo apt install mysql-server -y
```

- Connexion à MySQL en tant qu’administrateur root

```sh
sudo mysql -uroot -p

# Passage en mode superutilisateur (root)
sudo su
# Changer le mot de passe du compte root Linux
passwd
# Vous serez invité à entrer un nouveau mot de passe et à le confirmer
New password:
Retype new password:
passwd: password updated successfully
exit
```

- Cela vous connecte à MySQL avec l’utilisateur root. Vous devez entrer le mot de passe root (ou appuyer sur Entrée si aucun mot de passe n’a été défini).

#### Création de la base de données et utilisateur pour Zabbix

- Créez une base de données pour Zabbix

```sh
create database zabbix character set utf8mb4 collate utf8mb4_bin;
```

- a - La base s’appelle zabbix.
- b - Elle utilise l’encodage UTF-8 (nécessaire pour les caractères spéciaux).

- Créez un utilisateur MySQL pour Zabbix

```sh
create user zabbix@localhost identified by 'cfitech63@@';
```

- L’utilisateur s’appelle zabbix.
- Son mot de passe est cfitech63@@. (Attention ! Utilisez un mot de passe plus sécurisé en production.)

- Donnez tous les droits à cet utilisateur sur la base zabbix

```sh
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
```

- Activez une option nécessaire pour importer les fonctions dans MySQL (vous la désactiverez plus tard)

```sh
set global log_bin_trust_function_creators = 1;
```

- Quittez MySQL

```sh
quit;
```

- Importer le schéma SQL dans la base Zabbix

```sh
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

- Décompresse le fichier SQL (server.sql.gz) contenant la structure et les données initiales nécessaires à Zabbix.
- Exécute ce fichier dans la base zabbix, en utilisant l’utilisateur zabbix.

- **Note**: Vous devrez entrer le mot de passe de l’utilisateur zabbix (dans ce cas, cfitech63@@).

#### Désactiver l’option temporaire dans MySQL

- Après avoir importé les données, désactivez l’option activée précédemment

```sh
sudo mysql -uroot -p

mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
```

#### Configurer le serveur Zabbix

- Modifiez le fichier /etc/zabbix/zabbix_server.conf

```sh
sudo nano /etc/zabbix/zabbix_server.conf
```

- Trouvez la ligne contenant DBPassword= et ajoutez le mot de passe que vous avez défini pour l’utilisateur zabbix (ici, cfitech63@@)

```sh
DBPassword=cfitech63@@
```

Enregistrez et fermez le fichier (Ctrl+O, puis Ctrl+X avec Nano).

- Redémarrez les services nécessaires

```sh
sudo systemctl restart zabbix-server zabbix-agent apache2
```

- Activez-les pour qu’ils démarrent automatiquement au démarrage du serveur

```sh
sudo systemctl enable zabbix-server zabbix-agent apache2
```

- Accédez à votre serveur via son adresse IP ou son nom DNS

```sh
http://<adresse_IP_du_serveur>/zabbix
```

#### Suivez l’assistant d’installation dans l’interface web.

- Les identifiants par défaut sont :

  - Nom d’utilisateur : Admin
  - Mot de passe : zabbix

#### Points importants

- Sécurité :

  - Changez tous les mots de passe par des mots de passe forts.
  - Configurez HTTPS pour sécuriser l’accès à l’interface web.

- Pare-feu :

  - Assurez-vous que les ports nécessaires sont ouverts (par exemple, port 80 ou 443 pour l’interface web, port 10050 pour l’agent).

- Synchronisation horaire :

  - Installez et configurez NTP ou chrony pour synchroniser l’heure du serveur (important pour éviter des problèmes avec Zabbix).

