# Surveillance du réseau à l'aide de Grafana, Prometheus et Ping ExporterMonitoring

- Surveillance de base à l'aide d'ICMP / Ping pour les périphériques réseau

#### Instructions

- L'exportateur Ping peut être trouvé [ici.](https://github.com/czerwonk/ping_exporter)

#### Installer l'exportateur ping à l'aide de Docker (exécuté en tant que démon)

- Exécutez le conteneur Docker ping_exporter, en mappant le fichier config.yml que vous avez modifié.

```sh
docker run --init -d -p 9427:9427 -v /home/ubuntu/ping_exporter/config.yml:/config/config.yml --name ping_exporter czerwonk/ping_exporter
```

- Vérifiez que le conteneur est en cours d’exécution

```sh
docker ps

curl localhost:9427  # (ou ouvrir dans le navigateur)
```

- Configurer Prometheus à l'aide de nano

```sh
cd ../prometheus

nano prometheus.yml
```

- Démarrer le conteneur Prometheus à l'aide de Docker

```sh
cd ../prometheus

docker volume create prometheus-data

docker run --name prometheus \
    -p 9090:9090 \
    -d \
    -v /home/ubuntu/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v prometheus-data:/prometheus \
    prom/prometheus
```

- Configurer Grafana à l'aide de Docker

  - Créez un volume persistant pour vos données

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

- Créer un tableau de bord dans Grafana à l'aide de l'interface utilisateur
  - Étiquette personnalisée

```sh
{{target}}
```

![network](/Prometheus-Grafana-Network/Network/01.png)

![network](/Prometheus-Grafana-Network/Network/02.png)

![network](/Prometheus-Grafana-Network/Network/03.png)

![network](/Prometheus-Grafana-Network/Network/04.png)

![network](/Prometheus-Grafana-Network/Network/05.png)

![network](/Prometheus-Grafana-Network/Network/06.png)

![network](/Prometheus-Grafana-Network/Network/07.png)

![network](/Prometheus-Grafana-Network/Network/08.png)

![network](/Prometheus-Grafana-Network/Network/09.png)

### Liens utiles

[Ping Exporter](https://github.com/czerwonk/ping_exporter)

[Installing Prometheus using Docker](https://prometheus.io/docs/prometheus/latest/installation/#using-docker)

[Installing Grafana using Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/#run-grafana-docker-image)
