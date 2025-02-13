wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cp node_exporter-*.*-amd64/node_exporter /usr/local/bin

cp node_exporter.service /etc/systemd/system/node_exporter.service

cd /usr/local/bin

useradd -r node_exporter

sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter