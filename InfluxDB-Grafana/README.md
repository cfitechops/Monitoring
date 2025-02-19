# InfluxDB

```sh
barry@Thierno:~/Monitoring/InfluxDB-Grafana/influxdb$ nano docker-compose.yml
```
 
```sh
version: "3.8"
services:
  influxdb:
    image: influxdb
    container_name: Monitor-InfluxDB
    ports:
      - 8086:8086
    volumes:
      - /home/barry/Monitoring/InfluxDB-Grafana/influxdb/data:/var/lib/influxdb2
      - /home/barry/Monitoring/InfluxDB-Grafana/influxdb/config:/etc/influxdb2
    restart: always
```

```sh
barry@Thierno:~/Monitoring/InfluxDB-Grafana/influxdb$ docker-compose up -d
barry@Thierno:~/Monitoring/InfluxDB-Grafana/influxdb$ ip a | grep 192
```

![InfluxDB](/InfluxDB-Grafana/assets/01.png)

![InfluxDB](/InfluxDB-Grafana/assets/02.png)

![InfluxDB](/InfluxDB-Grafana/assets/03.png)

![InfluxDB](/InfluxDB-Grafana/assets/04.png)

![InfluxDB](/InfluxDB-Grafana/assets/05.png)

![InfluxDB](/InfluxDB-Grafana/assets/06.png)

![InfluxDB](/InfluxDB-Grafana/assets/07.png)

![InfluxDB](/InfluxDB-Grafana/assets/08.png)

# Grafana

```sh
version: "3.8"
services:
  grafana:
    image: grafana/grafana:latest
    container_name: Monitor-Grafana
    ports:
      - 3000:3000
    volumes:
      - /home/barry/Monitoring/InfluxDB-Grafana/influxdb/data:/var/lib/grafana
    user: "1000:1000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    restart: always
    networks:
      - galaxy
networks:
  galaxy:
    driver: bridge
```

```sh
barry@Thierno:~/Monitoring/InfluxDB-Grafana/grafana$ docker-compose up -d
```

![InfluxDB](/InfluxDB-Grafana/assets/09.png)

![InfluxDB](/InfluxDB-Grafana/assets/10.png)

![InfluxDB](/InfluxDB-Grafana/assets/11.png)

![InfluxDB](/InfluxDB-Grafana/assets/12.png)

![InfluxDB](/InfluxDB-Grafana/assets/13.png)

![InfluxDB](/InfluxDB-Grafana/assets/14.png)

![InfluxDB](/InfluxDB-Grafana/assets/15.png)

![InfluxDB](/InfluxDB-Grafana/assets/16.png)

![InfluxDB](/InfluxDB-Grafana/assets/17.png)

![InfluxDB](/InfluxDB-Grafana/assets/18.png)
