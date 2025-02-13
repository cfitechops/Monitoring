# Grafana en tant que service 

- Dans ce guide, Grafana sera configuré sur Ubuntu en tant que service.

#### OSS vs Enterprise 

- Grafana peut également être configuré pour s'exécuter dans Docker ou dans le cloud avec Grafana Cloud. L'un des avantages de l'exécution locale de Grafana est qu'il s'agit d'une installation beaucoup plus propre. Avec Grafana Cloud, vous disposez de nombreuses sources de données et de tableaux de bord prédéfinis, ce qui peut le rendre plus « occupé » qu'avec une installation locale.

#### OSS vs Enterprise

- Il existe deux versions : OSS (open source) et Enterprise. Elles sont toutes deux gratuites et ont les mêmes fonctionnalités. Si vous souhaitez obtenir une licence et payer pour Grafana, utilisez la version Enterprise car elle peut être déverrouillée sans avoir à la réinstaller. J'utiliserai la version OSS dans ce guide.

#### apt vs .deb

- Il existe deux façons d'installer Grafana en tant que service, les deux sont décrites dans ce wiki.

  - La première méthode consiste à ajouter manuellement le paquet apt et à l'installer via apt.
  - La deuxième méthode consiste à télécharger le fichier .deb et à l'installer via dpkg. Lorsque vous utilisez apt, vous pouvez facilement mettre à jour Grafana vers la dernière version via apt. apt installera également automatiquement les dépendances. C'est ma méthode préférée, mais si vous souhaitez plus de contrôle sur les mises à jour, vous pouvez simplement installer le fichier .deb

#### 1 - Installation via CLI

- Installation des paquets nécessaires

```sh
sudo apt-get install -y apt-transport-https software-properties-common wget
```

- Ajout de la clé GPG Grafana

```sh
sudo mkdir -p /etc/apt/keyrings/

wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
```

- Ajout du dépôt Grafana à la liste des sources APT

```sh
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```

- Mise à jour des sources APT

```sh
sudo apt-get update
```

- Installation de Grafana

```sh
sudo apt-get install grafana -y
```

- Configuration du port (optionnel)

```sh
nano /etc/grafana/grafana.ini
```

```sh
http_port = 9999
```

#### 2 - Installation via deb

- Installation des dépendances

```sh
sudo apt-get install -y adduser libfontconfig1 musl
```

- Téléchargement du paquet Grafana (Alternative)

```sh
wget -P ~/ https://dl.grafana.com/oss/release/grafana_11.3.0_amd64.deb
```

- Installation du paquet Grafana (Alternative)

```sh
sudo dpkg -i ~/grafana_11.3.0_amd64.deb
```

- Rechargement du daemon Systemd

```sh
sudo systemctl daemon-reload
```

- Démarrage de Grafana

```sh
sudo systemctl start grafana-server
```

- Vérification du statut de Grafana

```sh
sudo systemctl status grafana-server
```

- Activation de Grafana au démarrage

```sh
sudo systemctl enable grafana-server
```
