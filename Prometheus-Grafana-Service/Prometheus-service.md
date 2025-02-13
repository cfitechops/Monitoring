```sh
wget -P ~/ https://github.com/prometheus/prometheus/releases/download/v3.1.0/prometheus-3.1.0.linux-amd64.tar.gz
tar -xvf prometheus-3.1.0.linux-amd64.tar.gz
sudo mv prometheus-3.1.0.linux-amd64 /etc/prometheus
sudo rm -f prometheus-3.1.0.linux-amd64.tar.gz
sudo useradd -r --no-create-home --shell /bin/false prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus/
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus
sudo nano /etc/prometheus/prometheus.yml
```

```sh
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
```

```sh
sudo systemctl restart prometheus
sudo systemctl status prometheus
```
