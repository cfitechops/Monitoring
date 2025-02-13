# 1 - Installation et configuration de Grafana

- Dans ce guide, Grafana sera configuré sur Ubuntu en tant que service.

#### OSS vs Enterprise

- Grafana peut également être configuré pour s'exécuter dans Docker ou dans le cloud avec Grafana Cloud. L'un des avantages de l'exécution locale de Grafana est qu'il s'agit d'une installation beaucoup plus propre. Avec Grafana Cloud, vous disposez de nombreuses sources de données et de tableaux de bord prédéfinis, ce qui peut le rendre plus « occupé » qu'avec une installation locale.

#### OSS vs Enterprise

- Il existe deux versions : OSS (open source) et Enterprise. Elles sont toutes deux gratuites et ont les mêmes fonctionnalités. Si vous souhaitez obtenir une licence et payer pour Grafana, utilisez la version Enterprise car elle peut être déverrouillée sans avoir à la réinstaller. J'utiliserai la version OSS dans ce guide.

#### apt vs .deb

- Il existe deux façons d'installer Grafana en tant que service, les deux sont décrites dans ce wiki.

  - La première méthode consiste à ajouter manuellement le paquet apt et à l'installer via apt.
  - La deuxième méthode consiste à télécharger le fichier .deb et à l'installer via dpkg. Lorsque vous utilisez apt, vous pouvez facilement mettre à jour Grafana vers la dernière version via apt. apt installera également automatiquement les dépendances. C'est ma méthode préférée, mais si vous souhaitez plus de contrôle sur les mises à jour, vous pouvez simplement installer le fichier .deb

#### a - Ajouter le dépôt Grafana

```sh
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
```

- Mettre à jour les paquets et installer Grafana

```sh
sudo apt-get update
sudo apt-get install grafana
```

- Changer le port HTTP par défaut (3000 → 9999)

```sh
nano /etc/grafana/grafana.ini
```

- Rechercher la section [server] et modifier

```sh
[server]
http_port = 9999
```

- autoriser l'accès au port 9999

```sh
sudo ufw allow 9999/tcp
sudo ufw reload
```

- Démarrer et activer Grafana au démarrage

```sh
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

- Vérification du statut de Grafana

```sh
sudo systemctl status grafana-server
```

#### b - Installation via deb

- Installation des dépendances

```sh
sudo apt-get install -y adduser libfontconfig1 musl
```

- Téléchargement du paquet Grafana (Alternative)

```sh
wget -P ~/ https://dl.grafana.com/oss/release/grafana_11.5.1_amd64.deb
```

- Installation du paquet Grafana (Alternative)

```sh
sudo dpkg -i ~/grafana_11.5.1_amd64.deb
```

- Rechargement du daemon Systemd

```sh
sudo systemctl daemon-reload
```

- Démarrer et activer Grafana

```sh
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

- Vérification du statut de Grafana

```sh
sudo systemctl status grafana-server
```

# 2 - Installation et configuration de Prometheus

- Télécharge l'archive de Prometheus depuis le dépôt GitHub dans le répertoire personnel

```sh
wget -P ~/ https://github.com/prometheus/prometheus/releases/download/v3.1.0/prometheus-3.1.0.linux-amd64.tar.gz
```

- Extrait le contenu de l'archive téléchargée

```sh
tar -xvf prometheus-3.1.0.linux-amd64.tar.gz
```

- Déplace les fichiers extraits vers le répertoire /etc/prometheus

```sh
sudo mv prometheus-3.1.0.linux-amd64 /etc/prometheus
```

- Supprime l'archive téléchargée pour économiser de l'espace disque

```sh
sudo rm -f prometheus-3.1.0.linux-amd64.tar.gz
```

- Crée un utilisateur système "prometheus" sans accès shell et sans répertoire personnel

```sh
sudo useradd -r --no-create-home --shell /bin/false prometheus
```

- Change le propriétaire du répertoire /etc/prometheus en "prometheus"

```sh
sudo chown -R prometheus:prometheus /etc/prometheus
```

- Crée un répertoire pour stocker les données de Prometheus

```sh
sudo mkdir /var/lib/prometheus
```

- Change le propriétaire du répertoire des données en "prometheus"

```sh
sudo chown -R prometheus:prometheus /var/lib/prometheus/
```

- Ouvre un éditeur pour créer/modifier le fichier de service systemd pour Prometheus

```sh
sudo nano /etc/systemd/system/prometheus.service
```

- Contenu du fichier /etc/systemd/system/prometheus.service

```sh
[Unit]
Description=Prometheus Monitoring System
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
```

- Recharge la configuration systemd pour inclure le nouveau service Prometheus

```sh
sudo systemctl daemon-reload
```

- Démarre le service Prometheus

```sh
sudo systemctl start prometheus
```

- Active le démarrage automatique de Prometheus au démarrage du système

```sh
sudo systemctl enable prometheus
```

- Vérifie que Prometheus est bien en cours d'exécution

```sh
sudo systemctl status prometheus
```

- Ouvre le fichier de configuration de Prometheus pour modification (scrape_configs)

```sh
sudo nano /etc/prometheus/prometheus.yml
```

- Contenu du fichier /etc/prometheus/prometheus.yml

```sh
# Configuration globale de Prometheus
global:
  scrape_interval: 15s # Intervalle global d'extraction des métriques (par défaut : 1 minute)
  evaluation_interval: 15s # Intervalle global d'évaluation des règles (par défaut : 1 minute)

# Configuration des jobs d'extraction des métriques (scrape_configs)
scrape_configs:
  # Job pour surveiller Prometheus lui-même (localhost:9090)
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
```

- Redémarre Prometheus pour appliquer les modifications dans la configuration

```sh
sudo systemctl restart prometheus
```

- Vérifie que Prometheus fonctionne correctement après redémarrage

```sh
sudo systemctl status prometheus
```

# 3 - Installation et configuration de Node Exporter

- Télécharge l'archive de Node Exporter depuis GitHub dans le répertoire personnel

```sh
wget -P ~/ https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
```

- Extrait le contenu de l'archive téléchargée

```sh
tar -xvf ~/node_exporter-1.8.2.linux-amd64.tar.gz
```

- Déplace le binaire Node Exporter dans /usr/local/bin/

```sh
sudo mv ~/node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/
```

- Supprime les fichiers extraits pour économiser de l'espace disque

```sh
rm -rf ~/node_exporter-1.8.2.linux-amd64*
```

- Crée un utilisateur système "node_exporter" sans accès shell et sans répertoire personnel

```sh
sudo useradd -r -s /bin/false -c "Node Exporter service account" node_exporter
```

- Change le propriétaire du binaire Node Exporter en "node_exporter"

```sh
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
```

- Ouvre un éditeur pour créer/modifier le fichier de service systemd pour Node Exporter

```sh
sudo nano /etc/systemd/system/node_exporter.service
```

- Contenu du fichier /etc/systemd/system/node_exporter.service

```sh
[Unit]
Description=Node Exporter Service

[Service]
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

- Recharge la configuration systemd pour inclure le nouveau service Node Exporter

```sh
sudo systemctl daemon-reload
```

- Démarre le service Node Exporter

```sh
sudo systemctl start node_exporter
```

- Active le démarrage automatique de Node Exporter au démarrage du système

```sh
sudo systemctl enable node_exporter
```

- Vérifie que Node Exporter est bien en cours d'exécution

```sh
sudo systemctl status node_exporter
```

- Ouvre le fichier de configuration de Prometheus pour ajouter Node Exporter comme cible à surveiller (scrape_configs)

```sh
sudo nano /etc/prometheus/prometheus.yml
```

- Ajout dans /etc/prometheus/prometheus.yml

```sh
scrape_configs:
  # Job pour surveiller Node Exporter (localhost:9100)
  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]
        labels:
          instance: "master-server"
```

- Redémarre Prometheus pour appliquer les modifications liées à Node Exporter dans la configuration

```sh
sudo systemctl restart prometheus
```

- Vérifie que Prometheus fonctionne correctement après redémarrage

```sh
sudo systemctl status prometheus
```

# 4 - Installation et configuration de Nvidia GPU Exporter

- Télécharge l'archive Nvidia GPU Exporter depuis GitHub dans le répertoire personnel

```sh
wget -P ~/ https://github.com/utkuozdemir/nvidia_gpu_exporter/releases/download/v1.2.1/nvidia_gpu_exporter_1.2.1_linux_x86_64.tar.gz
```

- Extrait l'archive téléchargée

```sh
tar -xvf ~/nvidia_gpu_exporter_1.2.1_linux_x86_64.tar.gz
```

- Déplace le binaire Nvidia GPU Exporter dans /usr/local/bin/

```sh
sudo mv ~/nvidia_gpu_exporter /usr/local/bin/nvidia_gpu_exporter
```

- Rend le binaire exécutable

```sh
sudo chmod +x /usr/local/bin/nvidia_gpu_exporter
```

- Supprime les fichiers inutiles après extraction

```sh
rm -rf ~/nvidia_gpu_exporter_1.2.* LICENSE
```

- Crée un utilisateur système "nvidia_gpu_exporter" sans accès shell et sans répertoire personnel

```sh
sudo useradd -r -s /bin/false nvidia_gpu_exporter
```

- Ouvre un éditeur pour créer/modifier le fichier de service systemd pour Nvidia GPU Exporter

```sh
sudo nano /etc/systemd/system/nvidia_gpu_exporter.service
```

- Contenu du fichier /etc/systemd/system/nvidia_gpu_exporter.service

```sh
[Unit]
Description=Nvidia GPU Exporter Service

[Service]
User=nvidia_gpu_exporter
ExecStart=/usr/local/bin/nvidia_gpu_exporter

[Install]
WantedBy=multi-user.target
```

- Recharge la configuration systemd pour inclure Nvidia GPU Exporter

```sh
sudo systemctl daemon-reload
```

- Démarre Nvidia GPU Exporter

```sh
sudo systemctl start nvidia_gpu_exporter
```

- Active Nvidia GPU Exporter au démarrage du système

```sh
sudo systemctl enable nvidia_gpu_exporter
```

- Vérifie que Nvidia GPU Exporter est bien en cours d'exécution

```sh
sudo systemctl status nvidia_gpu_exporter
```

- Ouvre le fichier de configuration de Prometheus pour ajouter Nvidia GPU Exporter comme cible à surveiller (scrape_configs)

```sh
sudo nano /etc/prometheus/prometheus.yml
```

- Ajout dans /etc/prometheus/prometheus.yml

```sh
scrape_configs:
  # Job pour surveiller Nvidia GPU Exporter (localhost:9835)
  - job_name: "nvidia_gpu_exporter"
    static_configs:
      - targets: ["localhost:9835"]
        labels:
          instance: "master-server"
```

- Redémarre Prometheus pour appliquer les modifications liées à Nvidia GPU Exporter dans la configuration

```sh
sudo systemctl restart prometheus
```

- Vérifie que Prometheus fonctionne correctement après redémarrage

```sh
sudo systemctl status prometheus
```
