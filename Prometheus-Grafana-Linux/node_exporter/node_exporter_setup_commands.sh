wget https://github.com/prometheus/node_exporter/releases/download/v1.9.0/node_exporter-1.9.0.linux-amd64.tar.gz
#tar xvfz node_exporter-*.*-amd64.tar.gz

sudo cp node_exporter-*.*-amd64/node_exporter /usr/local/bin

cd /usr/local/bin

nano /etc/systemd/system/node_exporter.service

```sh
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=node_exporter  
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
```
useradd -r node_exporter
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

