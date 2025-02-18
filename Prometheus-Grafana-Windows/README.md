# Surveillance du serveur Windows à l'aide de Grafana, Prometheus et Windows Exporter

- Surveillance de base d'un serveur Windows à l'aide d'un exportateur dédié

#### Instructions

- L'exportateur Windows est disponible [ici.](https://github.com/prometheus-community/windows_exporter/releases)

  - Il doit être installé sur chaque hôte que vous souhaitez surveiller. Il est préférable d'effectuer cette opération à l'aide d'une installation scriptée ou d'une distribution via Active Directory si vous devez le faire à grande échelle.

#### Démarrer le conteneur Prometheus à l'aide de Docker

```sh
cd ../prometheus

sudo docker volume create prometheus-data

sudo docker run --name prometheus \
    -p 9090:9090 \
    -d \
    -v /home/ubuntu/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v prometheus-data:/prometheus \
    prom/prometheus
```

#### Configurer Grafana à l'aide de Docker

Créez un volume persistant pour vos données

```sh
sudo docker volume create grafana-storage

sudo docker run -d -p 3000:3000 --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  grafana/grafana-enterprise
```

- Connectez-vous à Grafana à l'aide du navigateur pour vous connecter au port Grafana 3000, par exemple http://192.168.x.x:3000

  - Informations d'identification par défaut

```sh
nom d'utilisateur = admin

mot de passe = admin
```

#### Créer un tableau de bord dans Grafana à l'aide de l'interface utilisateur

- Étiquette personnalisée

```sh
{{target}}
```

![network](/Prometheus-Grafana-Windows/Windows/01.png)

![network](/Prometheus-Grafana-Windows/Windows/02.png)

![network](/Prometheus-Grafana-Windows/Windows/03.png)

![network](/Prometheus-Grafana-Windows/Windows/04.png)

![network](/Prometheus-Grafana-Windows/Windows/05.png)

```sh
C:\Users\Administrator> calc.exe
C:\Users\Administrator> charmap.exe
```

#### Liens utiles

[Exportateur Windows](https://github.com/prometheus-community/windows_exporter/releases)

[Installation de Prometheus à l'aide de Docker](https://prometheus.io/docs/prometheus/latest/installation/#using-docker)

[Installer Grafana avec Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/#run-grafana-docker-image)
