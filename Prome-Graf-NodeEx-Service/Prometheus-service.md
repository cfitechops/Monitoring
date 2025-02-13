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

---

```sh
wget -P ~/ https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar -xvf ~/node_exporter-1.8.2.linux-amd64.tar.gz
sudo mv ~/node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/
rm -rf ~/node_exporter-1.8.2.linux-amd64\*
sudo useradd -r -s /bin/false -c "Node Exporter service account" -d /nonexistent node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
sudo nano /etc/systemd/system/node_exporter.service
```

```sh
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
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
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]
        labels:
          instance: "master-server"
```

```sh
sudo systemctl restart prometheus
sudo systemctl status prometheus
```

---

```sh
wget -P ~/ https://github.com/utkuozdemir/nvidia_gpu_exporter/releases/download/v1.2.1/nvidia_gpu_exporter_1.2.1_linux_x86_64.tar.gz
tar -xvf ~/nvidia_gpu_exporter_1.2.1_linux_x86_64.tar.gz
sudo mv ~/nvidia_gpu_exporter /usr/local/bin/nvidia_gpu_exporter
sudo chmod +x /usr/local/bin/nvidia_gpu_exporter
rm -rf ~/nvidia_gpu_exporter_1.2.1_linux_x86_64\*
rm LICENSE
sudo useradd -r -s /bin/false -c "nvidia_gpu_exporter service account" -d /nonexistent nvidia_gpu_exporter
sudo nano /etc/systemd/system/nvidia_gpu_exporter.service
```

```sh
[Unit]
Description=Nvidia GPU Exporter
After=network-online.target

[Service]
Type=simple

User=nvidia_gpu_exporter
Group=nvidia_gpu_exporter

ExecStart=/usr/local/bin/nvidia_gpu_exporter

SyslogIdentifier=nvidia_gpu_exporter

Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl start nvidia_gpu_exporter
sudo systemctl enable nvidia_gpu_exporter
sudo systemctl status nvidia_gpu_exporter
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
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]
        labels:
          instance: "master-server"

  - job_name: "nvidia_gpu_exporter"
    static_configs:
      - targets: ["localhost:9835"]
        labels:
          instance: "master-server"
```

```sh
sudo systemctl restart prometheus
sudo systemctl status prometheus
```
