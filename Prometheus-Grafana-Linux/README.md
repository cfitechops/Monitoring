# Surveillance du serveur Linux à l'aide de Grafana, Prometheus et Linux Node Exporter

- Surveillance de base d'un serveur Linux à l'aide de l'exportateur de nœuds

#### Instructions

- L'exportateur de nœuds Linux peut être trouvé [ici.](https://github.com/prometheus/node_exporter).

- Les instructions de Prometheus sont [ici](https://prometheus.io/docs/guides/node-exporter/)

- **Note**: Il doit être installé sur chaque hôte que vous souhaitez surveiller.

#### Configurer l'exportateur de nœuds

- Clonez le référentiel et exécutez les commandes conformément au fichier node_exporter_setup_commands.sh.

#### Démarrer le conteneur Prometheus à l'aide de Docker

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

#### Configurer Grafana à l'aide de Docker

- Créez un volume persistant pour vos données.

```sh
docker volume create grafana-storage

docker run -d -p 3000:3000 --name=grafana \
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

![network](/Prometheus-Grafana-Linux/linux/01.png)

![network](/Prometheus-Grafana-Linux/linux/02.png)

![network](/Prometheus-Grafana-Linux/linux/03.png)

![network](/Prometheus-Grafana-Linux/linux/04.png)

#### Liens utiles

[Exportateur de nœuds Linux](https://github.com/prometheus/node_exporter)

[Installation de Prometheus à l'aide de Docker](https://prometheus.io/docs/prometheus/latest/installation/#using-docker)

[Installer Grafana avec Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/#run-grafana-docker-image)
